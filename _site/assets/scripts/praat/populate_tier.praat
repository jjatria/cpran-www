# The script takes a collection of TextGrid files and an input text file.
# Lines in the input text file are separated into tokens, and then assigned
# to the labels of the corresponding TextGrid. The script works with point
# and interval tiers.
#
# The separator character (or characters) is a space by default, but can be
# be assigned in the script.
# 
# Written by Jose J. Atria (14 February 2014)
#
# This script is free software: you can redistribute it and/or modify 
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

form Populate tier
  sentence Input_text_file
  sentence TextGrid_directory
  comment Leave empty for GUI selectors
  integer Tier 1
  boolean Ignore_boundary_intervals yes
  boolean Output_to_disk no
  comment Writing output to disk will overwrite you TextGrids!
endform

@checkDirectory(textGrid_directory$, "Choose TextGrid directory...")
textGrid_directory$ = checkDirectory.name$

@checkFilename(input_text_file$, "Choose input text file...")
input_text_file$ = checkFilename.name$

strings = Read Strings from raw text file: input_text_file$
string_number = Get number of strings
textgrids = Create Strings as file list: "textgrids", textGrid_directory$ + "/*.TextGrid"
textgrid_number = Get number of strings

separator$ = " "

if textgrid_number != string_number
  exitScript("Number of TextGrid objects and token strings DO NOT match")
endif
 
for s to string_number
  selectObject(strings)
  string$ = Get string: s
  
  selectObject(textgrids)
  file_name$ = Get string: s
  
  textgrid = Read from file: textGrid_directory$ + "/" + file_name$

  @split (separator$, string$)
  total_tokens = split.length
  for t to total_tokens
    token$[t] = split.array$[t]
  endfor
    
  selectObject(textgrid)
  
  interval_tier = Is interval tier: tier
  if interval_tier
    tier_type$ = "interval"
    total_slots = Get number of intervals: tier
    if ignore_boundary_intervals
      total_slots -= 2
    endif
  else
    tier_type$ = "point"
    total_slots = Get number of points: tier
  endif
 
  if total_tokens = total_slots
  
    for i to total_slots
      if interval_tier
        Set interval text: tier, i+ignore_boundary_intervals, token$[i]
      else
        Set point text: tier, i, token$[i]
      endif
    endfor
    
    if output_to_disk
      Write to text file: textGrid_directory$ + "/" + file_name$
      removeObject(textgrid)
    endif
    
  else
    appendInfoLine("Number of ", tier_type$+"s", " is different from number of tokens for ", file_name$)
  endif
endfor

removeObject(strings, textgrids)

procedure checkFilename (.name$, .label$)
  if .name$ = ""
    .name$ = chooseReadFile$(.label$)
    if .name$ = ""
      exit
    endif
  endif
endproc

procedure checkDirectory (.name$, .label$)
  if .name$ = ""
    .name$ = chooseDirectory$(.label$)
    if .name$ = ""
      exit
    endif
  endif
endproc

# From http://www.ucl.ac.uk/~ucjt465/scripts/praat.html#split
procedure split (.sep$, .str$)
  .seplen = length(.sep$)
  .length = 0
  repeat
    .strlen = length(.str$)
    .sep = index(.str$, .sep$)
    if .sep > 0
      .part$ = left$(.str$, .sep-1)
      .str$ = mid$(.str$, .sep+.seplen, .strlen)
    else
      .part$ = .str$
    endif
    .length = .length+1
    .array$[.length] = .part$
  until .sep = 0
endproc