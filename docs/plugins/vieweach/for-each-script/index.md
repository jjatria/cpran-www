---
layout: page
group: pod
title: Execute for each...
---
{% include JB/setup %}

This command is provided by `vieweach` and accessible through the GUI via `Praat > CPrAN > vieweach > Execute for each...`.

When called, the script takes two arguments:

* The path to a script on disk

* A bundling option

Upon submitting the form, the script identified by that path is passed to [`for_each`][for_each procedure] for iteration over a given combination of sets.

[for_each procedure]: {{ BASE_PATH }}/docs/plugin/vieweach/for-each-procedure

How the selected objects are mapped to sets of objects that `for_each` can understand is specified via the bundling options:

* **Don't bundle** means that the script should do no bundling, and iterate through the selected objects in the Objects list as they are, from top to bottom, one at a time.

* **Per type** instructs the script to generate as many sets of objects as different types of objects are selected, and use those sets to iterate over. This means that the nunmber of iterations will be equal to the number of objects of the type that occupies most of the current selection.

* **Use sets** also tells the script to do no automatic bundling, but in this case it should consider that the selected objects are already [definitions of sets][defining sets]. If a non-default order of elements is needed, this is the way to do it: by manually re-ordering the set of objects / files and running it with the "use sets" option.

[defining sets]: {{ BASE_PATH }}/docs/plugin/vieweach/defining-sets
