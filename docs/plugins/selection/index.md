---
layout: page
group: pod
title: selection
---
{% include JB/setup %}

A large number of the commands available in Praat are context-dependent, in the
sense that their availability depends both on the type and sometimes number of
objects that are selected at any one time

However, despite selections being so important for the Praat workflow, there are
few features geared specifically to complex selection management. The
"selection" plugin aims to fill that void.

## Overview

Praat does not allow for the creation of custom object types, so selections for
this plugin are represented using Table objects. Each of these _selection
tables_ holds information about a set of selected objects, including their
names, types, and id numbers.

A _selection table_ is nothing but a Table containing the following columns:

`type`
  : the type of a given object as a string

`name`
  : the name of a given object as a string

`n`
  : a placeholder variable holding the value `1`

`id`
  : the id number of the corresponding object

The procedures provided by this plugin are designed to make it easier to
generate these tables automatically from the existing selection or manually, and
to manipulate and combine existing tables, and of course to use them to modify
the current selection.

**Any** Table object with _at least_ those columns can be considered a
_selection table_, and can be processed with this plugin. Below, all procedures
are explained in an order that will hopefully make it easier to learn how to use
them.

Since the plugin works with selections, and creating new objects modifies the
selection, great care has been used to make sure that calling these procedures
_does not modify the current selection_. When this cannot be done, or when it
doesn't make sense to maintain it, a special note is made.


## Procedures

### Basic usage

    clearinfo

    # Save the selection to an internal indexed variable
    @saveSelection()

    # Loop through selection
    for i to saveSelection.n
      selectObject: saveSelection.id[i]
      appendInfoLine: selected$()
    endfor

    # Restore original selection
    @restoreSelection()

#### saveSelection()

This procedure represents the most basic use case, and was indeed the first to
be written. It will loop through the selected objects and save them into an
internal indexed variable, which can later be used directly to select individual
objects.

In that sense, this procedure is entirely equivalent to the idiomatic

    for i to numberOfSelected()
      my_object[i] = selected(i)
    endfor

which means that this procedure **does not** save the selection anywhere but in
the so-called _local_ indexed variable of the procedure. This makes it
_extremely_ fragile: each time the procedure is called, the selection that was
"saved" will be overwritten.

If there's any chance more than one selection will need to be saved, then prefer
[saveSelectionTable()](#saveselectiontable) instead. Otherwise, this procedure
is still useful for simple scripts.

### Using selection tables

#### restoreSelection()

The companion procedure to [saveSelection()](#saveselection), it will read the
internal indexed variable from that procedure and restore the selection saved
in it. Do not call this procedure before a call before
[saveSelection()](#saveselection) has been called!

The equivalent procedure to restore a selection table is
[restoreSavedSelection(table)](#restoresavedselection).

#### saveSelectionTable()

Creates a selection table representing the selection that was active when the
procedure was called. The id of the table is stored in the internal variable
`.table`.

Since the selection is stored in an independent and persistent object, any
number of these selections can be saved simultaneously, without fear that they
will get in each other's way.

The Table that is created can be manipulated in all the ways in which a normal
Table can, as long as it still contains the fields specified [above](#overview).

The saved selection can be restored using
[restoreSavedSelection(table)](#restoresavedselection).

    @saveSelectionTable()
    selectObject: saveSelectionTable.table
    sounds = Extract rows where column (text): "type", "is equal to", "Sound"
    selectObject: table
    pitchs = Extract rows where column (text): "type", "is equal to", "Pitch"

#### saveTypeSelection(type$)

Similar to [saveSelectionTable()](#saveselectiontable), but it takes a string
holding the name of a valid Praat object type as its only argument. It generates
a selection table containing only the objects of type `type$` that are in the
current selection. As in [saveSelectionTable()](#saveselectiontable), the id of
the new Table will be stored in the variable `.table`.

    @saveTypeSelectionTable("Sound")
    sounds = saveTypeSelectionTable.table
    @saveTypeSelectionTable("Pitch")
    pitchs = saveTypeSelectionTable.table

#### restoreSavedSelection(table)

This procedure takes the id of a single selection table as its only argument,
and selects the objects specified therein. This will, of course, modify the
current selection.

Restoring a saved selection does not remove the selection table from the object
list. You may want to use [selectSelectionTables()](#selectselectiontables) to
make it easier to manage the selection tables that have been created.

#### plusSavedSelection(table)

Takes the id of a selection table, and appends that selection to the existing
selection. It can also be thought of as an equivalent of `plus` or
`plusObject()`, with the exception that this procedure adds the entire selection
that is stored in the table.

The new selection will not contain the selection table with the id in `table`
(unless the selection table contains itself).

#### minusSavedSelection(table)

Similar to [plusSavedSelection(table)](#plusSavedSelection), this substracts
the saved selection from the current one. Only objects in the saved selection
that are currently selected are removed; objects that are in the selection but
are not selected will be ignored.

### Creating selections from scratch

#### createEmptySelectionTable()

This procedure creates an empty selection table, with the proper column
structure but no rows. This is useful for procedurally generating new
collections of objects when the final number of objects is not known.

This procedure relies internally on
[createSelectionTable()](#createselectiontable)

The id of the generated table is stored in the `.table` variable.

#### createSelectionTable(rows)

This procedure takes a single number as its argument and creates an empty
selection table, with as many empty entries as indicated in it. This is useful
for procedurally generating new collections of objects.

The id of the generated table is stored in the `.table` variable.

#### addToSelectionTable(table, id)

Takes the id of a selection table and that of an object to add to the table. The
object id will only be added to the table if it points to an existing object and
if the object is not in the list initially (so there's no fear of adding the
same object more than once).

The modification of the table is done inline; no new Table object is created
in the process.

It is the equivalent of `plus` or `plusObject()` in the standard Praat toolkit,
but for saved selections.

#### removeFromSelectionTable(table, id)

Takes the id of a selection table and that of an object to remove from the
table. The id will only be removed if it is contained in the table; otherwise,
the procedure does nothing.

The modification of the table is done inline; no new Table object is created
in the process.

It is the equivalent of `minus` or `minusObject()` in the standard Praat
toolkit, but for saved selections.

### General selection management

#### clearSelection()

Deselects all selected objects. This is entirely equivalent to

    nocheck selecteObject: undefined

#### getId(table, index)

Given the id of a selection table, and a valid row number, this procedure gets
the id number of the object specified in that row.and stores it in the internal
`.id` variable.

#### selectSelectionTables()

Selects all the selection tables that exist in the Object list. This will
include any Table object that fits the definition stated above, so use with
care.

This procedure modifies the current selection.

The main use of this procedure is to facilitate clean up after many selection
tables have been generated. Thanks to it, getting rid of the tables themselves
is accomplished in two simple lines:

    @selectSelectionTables()
    Remove

#### selectType(type$)

Selects all objects of the type specified in `type$` from the Object list. This
will modify the current selection.

#### refineToType(type$)

Selects all objects of the type specified in `type$` from the current selection.
This will modify the current selection.
