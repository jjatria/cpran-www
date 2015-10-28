# Save all selected objects to disk. By default, the script overwrites
# existing files and prints the number of saved objects to the Info
# screen. This behaviour can be changed by modifying the overwrite and
# verbose variables respectively.
# 
# Written by Jose J. Atria (18 November 2011)
# Latest revision: February 21, 2014
# for the Laboratorio de Fonetica Letras UC
#
# This script is free software: you can redistribute it and/or modify 
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

overwrite = 1
verbose = 1

form Save selected objects...
  sentence Save_to
  comment Leave empty for GUI selector
endform

@checkDirectory(save_to$, "Save objects to...")
directory$ = checkDirectory.name$

n = numberOfSelected()
for i to n
  obj[i] = selected(i)
endfor

counter = 0
sameFile = 1
lastFilename$ = ""

for i to n
  selectObject(obj[i])
  objectType$ = extractWord$(selected$(), "")
  objectName$ = selected$(objectType$)

  if objectType$ = "Sound"
    extension$ = ".wav"
  elsif objectType$ != "LongSound"
    extension$ = "." + objectType$
  endif
  
  filename$ = directory$ + "/" + objectName$ + extension$
  
  if filename$ = lastFilename$
    paddedFilename$ = directory$ + "/" + objectName$ + string$(sameFile) + extension$
    sameFile += 1
  else
    paddedFilename$ = filename$
    sameFile = 1
  endif

  # Sound objects are saved as WAV files, everything else in plaintext
  if objectType$ = "Sound"
    if (fileReadable(paddedFilename$) and overwrite = 1) or !fileReadable(paddedFilename$)
      Save as WAV file: paddedFilename$
      counter += 1
    else
      if verbose
        appendInfoLine(paddedFilename$, " exists. Skipping...")
      endif
    endif
  else
    if (fileReadable(paddedFilename$) and overwrite = 1) or !fileReadable(paddedFilename$)
      Save as text file: paddedFilename$
      counter += 1
    else
      if verbose
        appendInfoLine(paddedFilename$, " exists. Skipping...")
      endif
    endif
  endif

  lastFilename$ = filename$
endfor

time$ = mid$(date$(), 12, 8)
if verbose
  plural$ = "s"
  verb$ = " were "

  if counter = 1
    plural$ = ""
    verb$ = " was "
  endif

  counter$ = if counter = 0 then "No" else string$(counter) fi
  
  appendInfoLine(counter$, " object", plural$, verb$, "saved in ", directory$, " (", time$, ")")
endif

if n
  selectObject(obj[1])
  for i from 2 to n
    plusObject(obj[i])
  endfor
endif

procedure checkDirectory (.name$, .label$)
  if .name$ = "" and praatVersion >= 5204
    .name$ = chooseDirectory$(.label$)
  endif
  if .name$ = ""
    exit
  endif
endproc