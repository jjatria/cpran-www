---
layout: page
group: pod
title: Defining sets
---
{% include JB/setup %}

## Sets

The iteration provided by `for_each` (and by extension by `view_each`) works on
sets of objects. In the simplest case, this would be a single set made up of a
number of selected objects from the Object list. Sets made up from objects that
exist in the Object list are represented by [_selection tables_][selection
tables], as implemented by the [selection][] plugin.

A set can also be made up from objects in disk, in which case they are
represented by `Strings` objects, in which each string contains _the full path_
to the specific file to be opened. These Strings with full paths can be created
with the `Create Strings as file list (full path)...` command from the
[strutils][] plugin.

[selection tables]: {{ BASE_PATH }}/plugins/selection#overview
[selection]: {{ BASE_PATH }}/plugins/selection
[strutils]: {{ BASE_PATH }}/plugins/strutils

Strings objects can also be used to represent sets of _directories_ on disk. To
distinguish paths to files from paths to directories, the latter need to end in
a `"/"` character, and also have full paths. Once again, the [strutils][] plugin
offers commands to do this.

## Looping

During iteration, one object from each of the appropriate sets will be selected
and become the active selection. This means that, with a single set of 20 Sound
objects, the iterator will loop 20 times, once with each Sound selected.
Similarly, if the iterator is called on a set of 10 Sound objects and 10
TextGrid objects, then each execution loop will have one Sound and one TextGrid
object selected.

Objects are taken sequentially from each set, so that the first time the
iterator loops, the first object from each set is selected, and so on. If the
sets are of unequal length, then the shorter set will loop over until all the
elements of the longest set have been iterated over at least once.

In the case of sets of directories, the object that will be selected with each
iteration is a Strings object with the full path to the files in that directory,
as returned by [strutils][].
