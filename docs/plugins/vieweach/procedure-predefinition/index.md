---
layout: page
group: pod
title: Procedure predefinition
---
{% include JB/setup %}

## The general idea

When writing extensible Praat scripts, it is useful to be able to specify what
code will be run for a specific operation. Depending on the context, these can
be called "[hooks][]" or "[callbacks][]", but their difference is not important
here.

[hooks]: https://en.wikipedia.org/wiki/Hooking
[callbacks]: https://en.wikipedia.org/wiki/Callback_%28computer_programming%29

In simple words, both cases refer to named pieces of code that are called at
specific points during the execution of a larger process. By redefining the
contents of those pieces of code the behaviour of the larger process can also be
manipulated.

One common example of this principle is found in JavaScript, which implements
the `onLoad` function which is called when elements are loaded on a webpage. By
default, this function is empty, meaning that the browser should do nothing when
the element is loaded, but this behaviour can be changed to have the browser do
all sorts of things.

Packages in LaTeX also commonly implement these so that you can specify what
should happen at the beginning or end of a specific environment, or every time a
new page is created, etc.

## How it would work in Praat

A simple version of this is implemented in the [Praat Vocal
Toolkit](http://www.praatvocaltoolkit.com), that uses a commonly named `action`
procedure that gets defined differently depending on the task at hand. But this
requires the procedure to be defined before the larger process can run.

An alternative is to use the deprecated variable interpolation, with a variable
holding the name of the correct procedure to run. The procedure call can then
interpolate the contents of this variable using single quotes. But this is risky
and not particularly safe, which is part of the reason variable interpolation is
being phased out.

But there is another way. In Praat there is no notion of a "named piece of
code". The closest we can get to what would in effect be a function is a
procedure, but these are more similar to a controlled `goto` block rather than
code that exists as such in memory. Since the code does not exist in memory as
code, it cannot be redefined through the means commonly used for this. But it
can be _predefined_.

When a procedure is called, execution of a Praat script jumps to the beginning
of the first procedure of that name and continues from there until reaching the
mark of the end of a procedure (`endproc`). When that line is reached, execution
jumps back up the stack to where it left off.

But if _two_ procedures with the same name are declared, the second procedure is
ignored, as in the following example:

    procedure quit ()
      appendInfoLine: "Hello World"
    endproc

    procedure quit ()
      exitScript: "Bye!"
    endproc

    @quit()
    # Prints "Hello World"

## As used by _vieweach_

The iterator procedures in `vieweach` are designed to be customizable and
extensible, and this customization is done by means of procedure predefinition.

Both [`for_each`][for_each procedure] and [`view_each`][view_each procedure]
start out by defining a set of empty procedures that will be called at specific
points during execution. Since all of them are defined, the user can concentrate
on predefining only those they are interested in (an improvement over Praat
Vocal Toolkit's method). And since these procedures are empty by default, unless
they _are_ predefined they will have no effect on the overall process.

Through carefully manipulating their contents, the user can change what should
happen at each step during the iteration. To do this, procedures need to be
defined _before the `include` line_ that loads in the external procedure
definitions. In the next example, the `for_each.action` procedure that runs at
the core of each iteration in `for_each` is redefined to make a copy of the
first selected object with the same name as the original object:

    procedure for_each.action ()
      .name$ = extractWord$(selected$(1), " ")
      selectObject: selected(1)
      Copy: .name$
    endproc

    include ../../plugin_vieweach/procedures/for_each.proc
    @for_each()

By the time `for_each` is read, the `for_each.action` procedure already exists,
which prevents the empty default definition from having an effect.

See the full documentation of [`for_each`][for_each procedure] and
[`view_each`][view_each procedure] for a full list of the available hooks and
what they mean.

[view_each procedure]: {{ BASE_PATH }}/docs/plugins/vieweach/view-each-procedure
[for_each procedure]: {{ BASE_PATH }}/docs/plugins/vieweach/for-each-procedure
