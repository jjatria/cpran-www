---
layout: page
group: pod
title: View each (from disk)...
---
{% include JB/setup %}

This command is provided by `vieweach` and accessible through the GUI via `Praat
> CPrAN > vieweach > View each (from disk)...`.

When called, the script takes two arguments:

* The path to a directory on disk from where to read objects

* A regular expression to match file names

Upon submitting the form, a [set][defining sets] with all the matching filenames
is generated and passed to [`view_each`][view_each procedure] to start a wizard
that iterates over the items in the set. A pause menu will allow the user to
move forward or backward (if possible) or to interrupt the wizard.

The wizard uses the procedures from `view_each` to implement the iteration,
which makes the engine very robust. While the wizard is running the user is free
to change the active selection, open and close other editors (or indeed the
active one), and even remove the selected objects from the list.

This robustness makes this script particularly useful for quick visual
exploration of a number of different objects.

[view_each procedure]: {{ BASE_PATH }}/docs/plugin/vieweach/view-each-procedure
[defining sets]: {{ BASE_PATH }}/docs/plugin/vieweach/defining-sets
