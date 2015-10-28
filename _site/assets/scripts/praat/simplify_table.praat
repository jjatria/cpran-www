# Simplifies the numeric contents of a Table object to an
# arbitrary degree of precision.
#
# Written by Jose J. Atria (7 March 2012)
# Tested to work with Praat v 5.3.06
#
# This script is free software: you can redistribute it and/or modify 
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

form Simplify Table...
  integer Precision 2
  word Suffix _simple
endform

n = numberOfSelected("Table")
for t to n
  table't' = selected("Table", t)
endfor

for t to n
  select table't'
  table$ = selected$("Table")
  Copy... 'table$''suffix$'

  table = selected("Table")
  rows = Object_'tabla'.nrow
  cols = Object_'tabla'.ncol

  for i to rows
    for j to cols
      colName$ = Get column label... j
      value$ = Get value... i  'colName$'
      if index_regex (value$, "^-?[0-9]+(.[0-9]+)?$")
        # Is a number
        value$ = fixed$ ('value$', precision)
        Set numeric value... i 'colName$' 'value$'
      endif
    endfor
  endfor
endfor