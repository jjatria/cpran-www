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
"selection" plugin aims to fill that void by providing a number of
[procedures](#procedures) to manipulate selections, and a set of
[scripts](#scripts) that encapsulate some of the more common use cases, and
showcase some possible applications of the plugin.

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

**Any** Table object with _at least_ those columns can be considered a
_selection table_, and can be processed with this plugin.

## Scripts

#### Copy selected
{: #copy-selected }

Similar to the `Copy...` command of the standard toolkit, this command copies
objects. But it can make copies of multiple objects at the same time. The new
objects are selected at the end.

No new selection tables remain in the object list.

#### Invert selection
{: #invert-selection }

Select all objects that were not selected when the command was called. Calling
the command twice returns the selection back to its initial state.

#### Save selection: name$
{: #save-selection }

The script version of [saveSelectionTable()](#save-selection-table). Running this
command will generate a new selection table containing the selection that was
active when it was called.

This command modifies the selection, since the new object is selected.

#### Restore selection
{: #restore-selection }

The script version of [restoreSavedSelection()](#restore-saved-selection). This
command requires the current selection to be a selection table. After calling
it, the new selection will be the one that was saved in that table.

This command modifies the selection.

#### Select types: types$, refine
{: #select-types }

<span><!-- Keep old links! --></span>
{: #select-one-type }

The script version of either [@selectTypes()](#select-types) or
[@refineToTypes()](#refine-to-types), depending on the value of the `refine`
boolean arcument. Calling this command will select objects of type `type$`,
either from the entire objects list if `refine` is false, or from the current
selection if `refine` is true.

This command modifies the selection.

#### Select selected types
{: #select-selected-types }

Another script version of [@selectTypes](#select-types), with the
difference that the value of `types$` is taken from the objects that are
currently selected.

This command modifies the selection.

#### Sort objects: fields, options
{: #sort-objects }

An experimetal command, `Sort objects...` rearranges the objects in the object
list according to the fields specified. By default, it sorts objects by name
and type, so that objects with the same name are placed next to each other
(which is particularly useful for pairs of, for example, Sound and TextGrid
objects).

Parts of its interface might change in the future, but it is useful mainly as an
illustration of the kinds of things that are possible with "selection".

## Procedures

Below, all procedures are explained in an order that will hopefully make it
easier to learn how to use them. They are designed to make it easier to generate
these tables automatically from the existing selection or manually, and to
manipulate and combine existing tables, and of course to use them to modify the
current selection.

Since the plugin works with selections, and creating new objects modifies the
selection, great care has been used to make sure that calling these procedures
_does not modify the current selection_. When this cannot be done, or when it
doesn't make sense to maintain it, a special note is made.

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

### `selection.proc`

#### saveSelection()
{: #save-selection }

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

#### restoreSelection()
{: #restore-selection }

The companion procedure to [saveSelection()](#saveselection), it will read the
internal indexed variable from that procedure and restore the selection saved
in it. Do not call this procedure before [saveSelection()](#saveselection) has

The equivalent procedure to restore a selection table is
[restoreSavedSelection(table)](#restoresavedselection).

#### plusSelection()
{: #plus-selection }

Also using [saveSelection()](#saveselection), this procedure will add the saved
selection to the current selection. Do not call this procedure before
[saveSelection()](#saveselection) has been called!

The equivalent procedure to restore a selection table is
[plusSavedSelection(table)](#plussavedselection).

#### minusSelection()
{: #minus-selection }

Also using [saveSelection()](#saveselection), this procedure will subtract the
saved selection from the current selection. Do not call this procedure before
[saveSelection()](#saveselection) has been called!

The equivalent procedure to restore a selection table is
[minusSavedSelection(table)](#minussavedselection).

### Using selection tables

#### saveSelectionTable()
{: #save-selection-table }

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
{: #save-type-selection }

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
{: #restore-saved-selection }

This procedure takes the id of a single selection table as its only argument,
and selects the objects specified therein. This will, of course, modify the
current selection.

Restoring a saved selection does not remove the selection table from the object
list. You may want to use [selectSelectionTables()](#selectselectiontables) to
make it easier to manage the selection tables that have been created.

#### plusSavedSelection(table)
{: #plus-saved-selection }

Takes the id of a selection table, and appends that selection to the existing
selection. It can also be thought of as an equivalent of `plus` or
`plusObject()`, with the exception that this procedure adds the entire selection
that is stored in the table.

The new selection will not contain the selection table with the id in `table`
(unless the selection table contains itself).

#### minusSavedSelection(table)
{: #minus-saved-selection }

Similar to [plusSavedSelection(table)](#plusSavedSelection), this substracts
the saved selection from the current one. Only objects in the saved selection
that are currently selected are removed; objects that are in the selection but
are not selected will be ignored.

### Creating selections from scratch

#### createEmptySelectionTable()
{: #create-empty-selection-table }

This procedure creates an empty selection table, with the proper column
structure but no rows. This is useful for procedurally generating new
collections of objects when the final number of objects is not known.

This procedure relies internally on
[createSelectionTable()](#createselectiontable)

The id of the generated table is stored in the `.table` variable.

#### createSelectionTable(rows)
{: #create-selection-table }

This procedure takes a single number as its argument and creates an empty
selection table, with as many empty entries as indicated in it. This is useful
for procedurally generating new collections of objects.

The id of the generated table is stored in the `.table` variable.

#### addToSelectionTable(table, id)
{: #add-to-selection-table }

Takes the id of a selection table and that of an object to add to the table. The
object id will only be added to the table if it points to an existing object and
if the object is not in the list initially (so there's no fear of adding the
same object more than once).

The modification of the table is done inline; no new Table object is created
in the process.

It is the equivalent of `plus` or `plusObject()` in the standard Praat toolkit,
but for saved selections.

#### removeFromSelectionTable(table, id)
{: #remove-from-selection-table }

Takes the id of a selection table and that of an object to remove from the
table. The id will only be removed if it is contained in the table; otherwise,
the procedure does nothing.

The modification of the table is done inline; no new Table object is created
in the process.

It is the equivalent of `minus` or `minusObject()` in the standard Praat
toolkit, but for saved selections.

### General selection management

#### clearSelection()
{: #clear-selection }

Deselects all selected objects. This is entirely equivalent to

    nocheck selecteObject: undefined

#### getId(table, index)
{: #get-id }

Given the id of a selection table, and a valid row number, this procedure gets
the id number of the object specified in that row.and stores it in the internal
`.id` variable.

#### selectSelectionTables()
{: #select-selection-tables }

Selects all the selection tables that exist in the Object list. This will
include any Table object that fits the definition stated above, so use with
care.

This procedure modifies the current selection.

The main use of this procedure is to facilitate clean up after many selection
tables have been generated. Thanks to it, getting rid of the tables themselves
is accomplished in two simple lines:

    @selectSelectionTables()
    Remove

#### selectTypes: types$
{: #select-types }

    Create SpeechSynthesizer: "English", "default"
    To Sound: "This is some text.", "yes"
    @saveSelection()

    Extract non-empty intervals: 3, "no"
    @restoreSelection()
    Remove

    @selectTypes: "Sound"
    To TextGrid: "Mary John bell", "bell"
    @selectTypes: "Sound TextGrid"

Selects all objects of the type specified in `types$` in the Object list.
Multiple object types can be passed simultaneously, separated by spaces.

This will modify the current selection.

#### refineToTypes: types$
{: #refine-to-types }

Selects all the objects of the type specified in `types$` in the current
selection. Multiple object types can be passed simultaneously, separated by
spaces.

This will modify the current selection.

#### plusTypes: types$
{: #plus-types }

Adds all the objects of the type specified in `types$` in the Object list to the
current selection. Multiple object types can be passed simultaneously, separated
by spaces.

This will modify the current selection.

#### minusTypes: types$
{: #minus-types }

Removes all the objects of the type specified in `types$` in the Object list
from the current selection. Multiple object types can be passed simultaneously,
separated by spaces.

This will modify the current selection.

### Object-type tables

#### checkSelection ()
{: #check-selection }

Generate a table with information about the current selection.

This procedure generates a table with the types of objects selected and the
number of selected objects per type. This can then be used to check for
parity between multiple object types (for instance, for pairing Sounds and
TextGrids).

#### checkSelectionTable: id
{: #check-selection-table }

Generate a table with information about the current selection.

This procedure generates a table with the types of objects selected and the
number of selected objects per type. This can then be used to check for
parity between multiple object types (for instance, for pairing Sounds and
TextGrids).

#### selectObjectTables ()

Selects all existing object tables.

This procedure will select all existing tables that look like object tables.

#### countObjects: id, type$

Counts the type of objects from an object table.

Provide the id of the object table and the name of the object type to count
