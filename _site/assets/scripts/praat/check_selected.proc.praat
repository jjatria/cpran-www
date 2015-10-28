# Check selection for unbalance: returns the number of selected object
# types as long as selection is balanced (there is an equal number of
# each type of object). The selected objects are stored in the array
# .objects$ of length .objects. Returns zero if selection is not
# balanced and -1 if there was no selection when procedure was called.
#
# Example:
#    call checkSelected 0
#    if checkSelected.objects > 0
#        print Balanced selection of 'checkSelected.objects' object types: 
#        for i to checkSelected.objects
#            o$ = checkSelected.objects$ [i]
#            print 'o$' 
#        endfor
#        print 'newline$'
#    elsif checkSelected.objects = 0
#        printline Selection is unbalanced
#    else
#        printline No selection.
#    endif
#
# Depending on the boolean value of KEEP, a Table object with the
# amount of objects of each type that were selected will remain
# upon completion.
#
# Written by Jose J. Atria (28 February 2012)
#
# This script is free software: you can redistribute it and/or modify 
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

procedure checkSelected .keep
    .n = numberOfSelected ()

    if .n
        for .i to .n
            .sel[.i] = selected(.i)
        endfor

        .table = Create Table with column names... objects 1 placeholder
        .objectList$ = ""

        .objects = 0
        for .i to .n
            select .sel[.i]
            .type$ = extractWord$(selected$() , "")
            select .table
            if !index (.objectList$, .type$)
                # New object type
                Append column... '.type$'
                .objects += 1
                .objects$ [.objects] = .type$
                Set numeric value... 1 '.type$' 1
                .objectList$ = .objectList$ + .type$ + " "
            else
                # Existing object, append to value
                .no = Get value... 1 '.type$'
                Set numeric value... 1 '.type$' .no+1
            endif
        endfor
        Remove column... placeholder

        .cols = Get number of columns
        for .i to .cols-1
            .col1$ = Get column label... .i
            .col2$ = Get column label... .i+1

            .x1 = Get value... 1 '.col1$'
            .x2 = Get value... 1 '.col2$'
            if .x1 != .x2
                .objects = 0
            endif
        endfor

        if !.keep
            select .table
            Remove
        endif

        # Restore original selection
        select .sel[1]
        for .i to .n
            plus .sel[.i]
        endfor
    else
        .objects = -1
    endif
endproc