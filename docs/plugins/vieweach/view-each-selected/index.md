---
layout: page
group: pod
title: View each (selected)
---
{% include JB/setup %}

This command is provided by `vieweach` and can be accessed in a variety of ways:

* It is always accessible through the GUI via `Praat > CPrAN > vieweach > View
each (selected)`, regardless of what is the current selection.

* With selections of a single type of objects **that have an editor**, the
command will also be available through the `View each` dynamic command.

* With selections of exclusively Sound and TextGrid objects, a specially named
`View each as pairs` replaces `View each`.

All of these call the same script and function in exactly the same way. The
script never takes any arguments.

When called, a wizard will start with the first of the selected objects (or, in
the case of `View each as pairs`, with a selection made up of the first Sound
and TextGrid objects combined) and a pause menu will allow the user to move
forward or backward (if possible) or to interrupt the wizard.

The wizard uses the procedures from `view_each` to implement the iteration,
which makes the engine very robust. While the wizard is running the user is free
to change the active selection, open and close other editors (or indeed the
active one), and even remove the selected objects from the list.

This robustness makes this script particularly useful for quick visual
exploration of a number of different objects.
