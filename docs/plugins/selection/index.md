---
layout: page
group: pod
title: selection
---
{% include JB/setup %}

## Procedures

### Basic usage

#### saveSelection()

This procedure takes no arguments. It will loop through the selected objects and
save them into an internal indexed variable. This indexed variable can then be
used directly to select individual objects.

This procedure **does not** save the selection anywhere but in the so-called
local variable of the procedure, which makes it _extremely_ fragile: each time
the procedure is called, the selection that was `saved` will be overwritten. If
there's any chance more than one selection will need to be saved, then prefer
[saveSelectionTable()](#saveselectiontable) instead. Otherwise, this procedure
is still useful for simple scripts.

~~~~
clearinfo
@saveSelection()
for i to saveSelection.n
  selectObject: saveSelection.id[i]
  appendInfoLine: selected$()
endfor
@restoreSelection()
~~~~

#### restoreSelection()

The companion procedure to [saveSelection()](#saveselection), it will read the
internal  indexed variable from that procedure and restore the selection saved
in it. This means that if this procedure is called before a call to
[saveSelection()](#saveselection), Praat will complain.

The equivalent procedure to restore a selection table is
[restoreSavedSelection(table)](#restoresavedselection).

#### saveSelectionTable()

Creates a **selection table** representing the current selection when the
procedure was called. The id of the table is stored in the internal variable
`.table`.

Since the selection is stored in an independent and persistent object, any
number of these selections can be saved simultaneously, without fear that they
will get into each other's way.

The `Table` that is created can be manipulated in all the ways in which a normal
`Table` can, as long as it still contains the fields specified
[above]({{ BASE_PATH }}/plugins/selection#overview).

The saved selection can be restored using
[restoreSavedSelection(table)](#restoresavedselection).

~~~~
@saveSelectionTable()
selectObject: saveSelectionTable.table
sounds = Extract rows where column (text): "type", "is equal to", "Sound"
selectObject: table
pitchs = Extract rows where column (text): "type", "is equal to", "Pitch"
~~~~

#### saveTypeSelection(type$)

Similar to [saveSelectionTable()](#saveselectiontable), but it takes a string
holding a valid Praat object name as its only argument. It generates a
**selection table**  containing only the objects of type `type$` that are in the
current selection. As in the other procedure, the id of the new `Table` will be
stored in the variable `.table`.

~~~~
@saveTypeSelectionTable("Sound")
sounds = saveTypeSelectionTable.table
@saveTypeSelectionTable("Pitch")
pitchs = saveTypeSelectionTable.table
~~~~

#### restoreSavedSelection(table)

This procedure takes the id of a single **selection table** as its only
argument, and selects the objects specified therein. This will, of course,
modify the current selection.

Restoring a saved selection does not remove the **selection table** from the
object list.

#### plusSavedSelection(table)

Takes the id of a selection table, and appends that selection to the existing
selection. It can also be thought of as an equivalent of `plus` or
`plusObject()`, with the exception that this procedure adds the entire selection
that is stored in the table.

#### minusSavedSelection(table)

Similar to [plusSavedSelection(table)](#plusSavedSelection), but substracts
the saved selection from the current one. Only objects in the saved selection
that are currently selected are removed; the selection table may contain other
objects, which will be ignored.

### Creating selections from scratch

#### createEmptySelectionTable()

This procedure creates an empty selection table, with the proper column
structure but no rows. This is useful for procedurally generating new
collections of objects when the final number of objects is not known.

This procedure relies internally on
[createSelectionTable()](#createselectiontable)

The id of the generated table is stored in the `.table` variable.

#### createSelectionTable(rows)

This procedure takes a single number as its argument and creates a blank
selection table, with as many empty entries as indicated in it. This is useful
for procedurally generating new collections of objects.

The id of the generated table is stored in the `.table` variable.

#### addToSelectionTable(table, id)

Takes the id of a **selection table** and that of an object to add to it. The
object id will only be added to the table if it points to an existing object and
if the object is not in the list initially (so there's no fear of adding the
same object more than once).

The modification of the table is done inline; no new `Table` object is created
in the process.

It is the equivalent of `plus` or `plusObject()` in the standard Praat toolkit,
but for saved selections.

#### removeFromSelectionTable(table, id)

Takes the id of a **selection table** and that of an object to remove from it.
The id will only be removed if it is contained in the table; otherwise, the
procedure does nothing.

The modification of the table is done inline; no new `Table` object is created
in the process.

It is the equivalent of `minus` or `minusObject()` in the standard Praat
toolkit, but for saved selections.

### General selection management

#### clearSelection()

Deselects all selected objects.

#### getId(table, index)

Given the id of a selection table, and a valid row number, the procedure gets
the id number of the object specified in that row.

The id is stored in the internal `.id` variable.

#### selectSelectionTables()

Selects all the **selection tables** that exist in the Object list. This will
include any `Table` object that fits the definition stated above, so use with
care.

This procedure modifies the current selection.

The main use of this procedure is to facilitate clean up after many selection
tables have been generated. Thanks to it, getting rid of the tables themselves
is accomplished in two simple lines:

~~~~
@selectSelectionTables()
Remove
~~~~

#### selectType(type$)

Selects all objects of the type specified in `type$` from the Object list. This
will modify the current selection.

#### refineToType(type$)

Selects all objects of the type specified in `type$` from the current selection.
This will modify the current selection.
