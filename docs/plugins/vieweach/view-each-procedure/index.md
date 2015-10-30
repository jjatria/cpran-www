---
layout: page
group: pod
title: view_each (procedure)
---
{% include JB/setup %}

`view_each` makes use of the general purpose iterator from [`for_each`][for_each
procedure] to implement a general purpose engine for making robust and highly
customisable wizards for Praat. Since it uses [`for_each`][for_each procedure]
in the background, the iteration uses the same notion of [sets of
objects][defining sets] to iterate over, and also implements [hooks](#hooks) for
customisation (see [procedure predefinition][]).

> Note: as far as Praat is concerned, **there is no difference between what are
> here called "procedures" and "hooks"**. The only difference is that the latter
> are designed to be overwritten, while the former are designed to be used as
> they are, but the user is free to ignore this (at their own risk).

## Variables

#### view_each.name$

The name of the editor, different for every iteration. Redefined only when an
editor is available.

## Procedures

#### view_each

The main iterating procedure, when called sets the wizard in motion. By the time
it is called, selected objects need to be objects [defining sets][].

#### in_editor

Procedure to determine whether execution is in editor mode or not.

Result is saved in `.return`, which is `0` if not in editor mode, `-1` if in an
unnumbered editor, or a positive number with the id of the object to whom the
editor belongs otherwise. An additional `.return$` variable stores the name of
the editor (or the empty string, if not in editor mode).

#### has_editor

Attempts to open an editor with the current combination of selected objects. By
default, it tries opening the editor using the `View & Edit`, `View` and `Edit`
commands, in that order.

To test whether an editor has been found, [`in_editor`](#ineditor) is called. If
successful, the `.return` and `.return$` variables from [`in_editor`](#ineditor)
are mapped to `.editor` and `.editor$` variables from
[`has_editor`](#haseditor).

#### _try_editor: .command$

Mainly for internal use. Attempts to open an editor for the current combination
of selected objects using the command provided as argument.

To test whether an editor has been found, [`in_editor`](#ineditor) is called. If
successful, the `.return` and `.return$` variables from [`in_editor`](#ineditor)
are mapped to `.editor` and `.editor$` variables from
[`_try_editor`](#tryeditor-command).

#### view_each.clean_exit: .message$

Called by [`for_each.clean_exit: .message$`][for_each clean_exit], allows the
user to clean the workspace before exiting the iteration. Empty by default.

## Hooks

#### view_each.before_iteration

Called by [`for_each.before_iteration`][for_each before_iteration], before the
main iteration begins.

#### view_each.at_begin_iteration

Called by [`for_each.at_begin_iteration`][for_each at_begin_iteration], at the
beginning of each iteration.

#### view_each.before_editor

Called during each iteration, before the editor is opened for the current
selection. This procedure only gets executed if the current selection has an
editor available.

#### view_each.at_begin_editor

Called during each iteration, immediately after the editor is open for the
current selection. This procedure is guaranteed to be called in editor mode.

By default, this procedure reads the name of the current editor and saves it in
[`view_each.name$`](#vieweachname). If this procedure is to be predefined, care
must be taken to define this variable elsewhere (or discard all the places where
it is referenced). The procedure's default definition is below:

    procedure view_each.at_begin_editor ()
      .editor$ = Editor info
      view_each.name$ = extractLine$(.editor$, "Editor name: ")
      view_each.name$ = mid$(view_each.name$,
        ... rindex(view_each.name$, " "), length(view_each.name$))
    endproc

#### view_each.pause

Called after the editor has been opened, and guaranteed to be called outside
editor mode.

#### view_each.at_end_editor

Called after the pause, before the editor has been closed by default (although
at this point it might have been closed via a predefined procedure). This
procedure is guaranteed to be called in editor mode (if the editor has been
closed before, then this procedure never gets called).

By default, this procedure closes the editor. Its default contents are as
follows:

    procedure view_each.at_end_editor ()
      Close
    endproc

#### view_each.after_editor

Called each iteration, after the editor has been closed. Guaranteed not to be in
editor mode.

#### view_each.no_editor

Called each iteration, in the case that the current selection does not have an
editor.

#### view_each.at_end_iteration

Called by [`for_each.at_end_iteration`][for_each at_end_iteration], at the end
of each iteration.

#### view_each.finally

Called by [`for_each.finally`][for_each finally], after the main loop has ended.

[defining sets]: {{ BASE_PATH }}/docs/plugins/vieweach/defining-sets
[procedure predefinition]: {{ BASE_PATH }}/docs/plugins/vieweach/procedure-predefinition
[for_each procedure]: {{ BASE_PATH }}/docs/plugins/vieweach/for-each-procedure
[for_each clean_exit]: {{ BASE_PATH }}/docs/plugins/vieweach/for-each-procedure#foreachcleanexit-message
[for_each before_iteration]: {{ BASE_PATH }}/docs/plugins/vieweach/for-each-procedure#foreachbeforeiteration
[for_each at_begin_iteration]: {{ BASE_PATH }}/docs/plugins/vieweach/for-each-procedure#foreachatbeginiteration
[for_each at_end_iteration]: {{ BASE_PATH }}/docs/plugins/vieweach/for-each-procedure#foreachatenditeration
[for_each finally]: {{ BASE_PATH }}/docs/plugins/vieweach/for-each-procedure#foreachfinally
