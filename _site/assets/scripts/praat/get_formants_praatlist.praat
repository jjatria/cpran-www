# Based on a script by Setsuko Shirai
# Updated and optimised by Jose Joaquin Atria (November 16, 2013)
 
form Get pitch and formant values...
  comment Leave paths blank for GUI selector
  sentence Input_directory
  sentence Output_directory
  sentence File_type wav
  positive Prediction_order 10
  positive Minimum_pitch 75
  positive Maximum_pitch 500
  positive New_sample_rate 11025
endform

if input_directory$ = ""
  @guiSelector("Choose input directory")
  input_directory$ = guiSelector.dir
endif

if output_directory$ = ""
  @guiSelector("Choose output directory")
  input_directory$ = guiSelector.dir
endif

timeStep = 0.01
f_precision = 2
time_precision = 5
sample_precision = 50
numberOfFormants = 3

fileList = do("Create Strings as file list...", "list", input_directory$ + "/*." + file_type$)
numberOfFiles = do("Get number of strings")

for i to numberOfFiles
  selectObject(fileList)
  filename$ = do$("Get string...", i)
  soundObject =  do("Read from file...", input_directory$ +"/" + filename$)

  resampledSound = do("Resample...", new_sample_rate, sample_precision)
  pitchObject = do("To Pitch...", timeStep, minimum_pitch, maximum_pitch)

  removeObject(soundObject)

  selectObject(resampledSound)
  intensityObject = do("To Intensity...", 100, 0)

  selectObject(resampledSound)
  lpcObject = do("To LPC (autocorrelation)...", prediction_order, 0.025, 0.005, 50)
  formantObject = do("To Formant")

  removeObject(resampledSound, lpcObject)

  tableObject = do("Create Table with column names...", "table", 0,
    ..."time pitch intensity formant1 formant2 formant3")

  selectObject(pitchObject)
  numberOfFrames = do("Get number of frames")
  for frame to numberOfFrames
    select pitchObject
    f0 = do("Get value in frame...", frame, "Hertz")
    @fixNumber(f0, f_precision)
    f0 = fixNumber.ans

    time = do("Get time from frame number...", frame)
    @fixNumber(time, time_precision)
    time = fixNumber.ans

    selectObject(intensityObject)
    intensity = do("Get value at time...", time, "Cubic")
    @fixNumber(intensity, f_precision)
    intensity = fixNumber.ans

    selectObject(formantObject)

    for f to numberOfFormants
      f[f] = do("Get value at time...", f, time, "Hertz", "Linear")
      @fixNumber(f[f], f_precision)
      f[f] = fixNumber.ans
    endfor

    selectObject(tableObject)
    do("Append row")
    thisRow = do("Get number of rows")
    do("Set numeric value...", thisRow, "time", time)
    do("Set numeric value...", thisRow, "pitch", f0)
    do("Set numeric value...", thisRow, "intensity", intensity)
    for f to numberOfFormants
      do("Set numeric value...", thisRow, "formant" + string$(f), f[f])
    endfor
  endfor

  filename$ = filename$ - ("." + file_type$)
  do("Write to table file...", output_directory$ + "/" + filename$ + ".xls")

  removeObject(tableObject, pitchObject, intensityObject, formantObject)
endfor

removeObject(fileList)

procedure fixNumber (.ans, .precision)
  .value = number(fixed$(.ans, .precision))
  if .ans = undefined
    .ans = 0
  endif
endproc

procedure guiSelector (.label$)
  .dir$ = chooseDirectory$(.label$)
  if .dir$ = ""
    exit
  endif
endproc