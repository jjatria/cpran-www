# Open TextGrid files corresponding to selected Sound objects
#
# The script will loop through all selected Sound objects 
# and look for a similarly named TextGrid file in the specified
# folder. If so desired, the script will also re-order the
# object list so that Sound objects appear right next to their
# TextGrids for easier manipulation. Alternatively, all
# TextGrids will appear at the end of the list.
#
# The current version uses a dirty hack for reordering the object
# list pending a better solution, long-standing in the Praat
# to do list.
#
# Written by Jose J. Atria (August 21, 2012)
# Requires Praat v 5.2.04+ for directory selector
#
# This script is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

form Open TextGrids...
  comment Type in path or leave empty to navigate directory structure (Praat 5.2.04 or higher)
  sentence Path_to_TextGrids 
  boolean Reorder_objects 1
  boolean Generate_missing 1
  boolean Verbose 1
endform

if path_to_TextGrids$ = ""
  if praatVersion >= 5204
    tgdir$ = chooseDirectory$("Choose TextGrid directory")
  else
    exit Your version of Praat ('praatVersion') does not support graphical directory selectors. Please manually provide a path or update to a more recent version.
  endif
else
  tgdir$ = path_to_TextGrids$
endif

if windows
  delim$ = "\"
else
  delim$ = "/"
endif

cleared = 0

n = numberOfSelected("Sound")
for i to n
  sound[i] = selected("Sound", i)
endfor
for i to n
  select sound[i]
  sname$ = selected$("Sound")
  tgname$ = tgdir$ + delim$ + sname$ + ".TextGrid"
  if fileReadable(tgname$)
    if reorder_objects
      s = sound[i]
      Copy... 'sname$'
      sound[i] = selected()
      select s
      Remove
    endif
    textgrid[i] = Read from file... 'tgname$'
  else
    if verbose
      if !cleared
        clearinfo
        cleared = 1
      endif
      printline W: 'sname$'.TextGrid not found in 'tgdir$'. Skipping...
    endif
  endif
endfor