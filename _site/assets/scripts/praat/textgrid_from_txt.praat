# Create TextGrids from txt files
# Written by Jose J. Atria (12 January 2012)
# Requires Praat v 5.2.03
#
# The script takes all the properly formatted txt files in the
# working directory and creates TextGrid objects from the data in them.
# The txt files must have one line per desired interval, with the label
# of the interval on one column and the duration of said interval
# on the other.
# The columns must be separated by tabs (or by whatever is set in delim$).
# All the relevant lines must end with a newline character.
#
# This script is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

if praatVersion < 5203
  exit Your version of Praat is too old. Please update Praat to use this script.
endif

wd$ = chooseDirectory$ ("Select working directory...")
if wd$ = ""
  exit
endif

if windows
  separator$ = "\"
else
  separator$ = "/"
endif
delim$ = tab$

# Finding files we are looking for
strings = Create Strings as file list... list 'wd$''separator$'*.txt
n = Get number of strings

# Loop through files
for i to n
  fileName$ = Get string... i
  fileName$ = wd$ + separator$ + fileName$
  if fileReadable(fileName$)
    text$ < 'fileName$'

    lines = 0
    repeat
      txtlen = length(text$)
      t = index(text$, newline$)
      line$ = left$(text$, t-1)

      if line$ != ""
        lines += 1
        tab = index(line$, delim$)
        if tab
          linelen = length(line$)
          label$[lines] = left$(line$, tab-1)
          dur$[lines] = right$(line$, linelen-tab)
        endif
      endif
      text$ = mid$(text$, t+1, txtlen)
    until t = 0

    totalDuration = 0
    for j to lines
      dur$ = dur$[j]
      dur = 'dur$'
      totalDuration += dur
    endfor

    textgrid = Create TextGrid... 0 totalDuration interval ""
    textGridName$ = fileName$ - ".txt"
    Rename... 'textGridName$'

    boundary = 0
    for j to lines
      dur$ = dur$[j]
      lab$ = label$[j]
      boundary += 'dur$'
      nocheck Insert boundary... 1 boundary
      Set interval text... 1 j 'lab$'
    endfor

  else
    printline File not readable. Skipping 'fileName$'
  endif
endfor

select strings
Remove
