---
layout: page
group: pod
title: for_each (procedure)
---
{% include JB/setup %}

`for_each` implements a general purpose, robust, and highly customisable
iterator for Praat objects. The iteration is run over [sets of objects][defining
sets] that exist either in the Object list, in disk, or in a combination of
both.

[defining sets]: {{ BASE_PATH }}/docs/plugins/vieweach/defining-sets
[procedure predefinition]: {{ BASE_PATH }}/docs/plugins/vieweach/procedure-predefinition

The customisation is done via [procedure predefinition][]. See [below](#hooks)
for a list of the individual predefinable procedures and what they mean.

> Note: as far as Praat is concerned, **there is no difference between what are
here called "procedures" and "hooks"**. The only difference is that the latter
are designed to be overwritten, while the former are designed to be used as they
are, but the user is free to ignore this (at their own risk).

## Variables

#### for_each.current

The number of this particular iteration, from 1 to [`.last`](#foreachlast).

#### for_each.last

The total number of iterations; the number of items in the largest set.

#### for_each.next

A variable specifying the what the next iteration will be. If `0`, iteration
stops. If non-zero, the value is added (or subtracted) to
[`.current`](#foreachcurrent) to specify what the next item will be.

#### for_each.selection

The id of a selection table specifying the selection for the current iteration.

#### for_each.sets

The id of the object representing the _set of sets_ of objects the iterator is
looping over.

#### for_each.total_sets

The number of sets that the iterator is running over; the number of selected
objects when [`for_each`](#foreach) was run.

## Procedures

#### for_each

The main iterating procedure, when called sets the iterations in motion. By the
time it is called, selected objects need to be objects [defining sets][].

#### for_each.clean_exit (.message$)

A convenience function, this is not called by default, but is made available so
that the user can establish a clean way to stop the iterator if need be. By
default, it attempts to restore the workspace to the state before execution, and
exits with the specified message. The default value is as follows:

    procedure for_each.clean_exit (.message$)
      nocheck removeObject: for_each.sets
      nocheck removeObject: for_each.selection
      nocheck removeObject: for_each.remove
      exitScript: .message$ + newline$
    endproc

#### for_each._select

Used mainly for internal purposes, this procedure makes a selection table
identifying the objects that are active for the current iteration. It does not
select these objects. The id of that selection table is stored in
[`for_each.selection`](#foreachselection).

## Hooks

#### for_each.before_iteration

Called right before the beginning of the looping block. When this procedure is
called, Praat knows about the number of sets to iterate over, as well as the
number of total iterations to run. If a starting point has been specified, this
is also known. There is no active selection.

#### for_each.at_begin_iteration

Called at the beginning of each iteration, before the selection has been made.
By default, no selection is available.

#### for_each.action

Called for each iteration, after the selection has been made.

#### for_each.at_end_iteration

Called at the beginning of each iteration, after the selection has been cleared.
This is the last piece of code to be read before reading the contents of
[`for_each.next`](#foreachnext), which defines the state of the next iteration.

#### for_each.finally

Called after execution has left the iterator, before complete clean-up is done.
This procedure does not have an empty default, so care should be taken when
predefining it. By default, it makes the iterator restore the selection of sets
of objects. The default definition is as follows:

    procedure for_each.finally ()
      selectObject: for_each.sets
      runScript: for_each.selection_scripts$ +
        ... "restore_selection.praat"
    endproc
