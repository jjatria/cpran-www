---
layout: page
group: pod
title: testsimple
---
{% include JB/setup %}

This plugin provides a framework to produce a TAP stream. TAP stands for the
"Test Anything Protocol", and according to [its website][tap], it "is a
simple text-based interface between testing modules in a test harness". Although
TAP has its origins tied to Perl, it has since then spread to a number of other
programming languages and environments, the most recent of which is Praat!

[tap]: http://testanything.org/

This plugin is only concerned with generating a compliant TAP stream, which will
look something like this:

    1..4
    ok 1 - Input file opened
    not ok 2 - First line of the input valid
    ok 3 - Read the rest of the file
    not ok 4 - Summarized correctly # TODO Not written yet

This means that four tests were planned, out of which two passed and two failed.
However, one of the failing tests has been explicitly marked as "TODO", meaning
that it was expected to fail... so it's OK.

To analyse these results, a "harness" is needed, which will read this input
stream and provide a report on the outcome of the entire test suite. Different
harnesses exist providing different features, and they should all work with this
same output.

The procedures in this plugin **do not provide a harness**. They only produce
the stream.

## Procedures

### `simple.proc`

The procedures made available using `simple.proc` are the same as those
provided by the **[testsimple][]** plugin.

[testsimple]: http://cpran.net/plugins/testsimple

#### plan: tests
{: #plan }

{% highlight praat %}
# Plan 10 tests
@plan: 10
# Prints out
#   1..10
{% endhighlight %}

Every TAP stream must either begin or end with a plan line, which specifies how
may tests will run, or have run. This is a safeguard in case your test file dies
silently in the middle of its run.

For **tap**, it is an error to begin a test suite without having first
specified a plan. That can be done by calling this procedure or, in the case
that a test suite does not know how many tests will be run, by explicitly
stating this with [`@no_plan`](#no-plan).

#### no_plan
{: #no-plan }

{% highlight praat %}
# If you do not know how many tests you'll run
@no_plan()
{% endhighlight %}

Sometimes a test suite will have an undetermined number of tests. In this case,
**tap** requires this to be explicitly stated before the first test takes
place by calling this procedure. Every test script using this plugin should
begin with a call to this procedure or to [`@plan`](#plan).

#### done_testing
{: #done-testing }

{% highlight praat %}
@done_testing()
{% endhighlight %}

This procedure marks the end of the testing suite. It generates no output if a
plan line has already been printed (with [`@plan`](#plan)), but is necessary
when [`@no_plan`](#no-plan) is in use.

It is an error to call this procedure more than once, or to call it before
either of the planning procedures has been called.

#### ok: test, description$
{: #ok }

{% highlight praat %}
Create TextGrid: "test", 0, 1, "tiers", ""
@ok: selected("TextGrid"), "TextGrid is selected"
# Prints
#   ok 1 - TextGrid is selected
{% endhighlight %}

The core of TAP is the test line. Test lines begin with either `ok` or `not ok`
depending on the result of the test. A number is expected to follow the result
of the test, although this is optional. After this, a test description _may_ be
printed.

This procedure takes care of generating all of these fragments, and internally
keeps track of the test number (so that successive calls to [`@ok`](#ok) will
print increasing numbers). The description provided as the second argument can
be the empty string.

#### ok_formula: formula$, description$
{: #ok-formula }

{% highlight praat %}
Create TextGrid: "test", 0, 1, "tiers", ""
@ok_formula: "selected(""TextGrid"")", "TextGrid is selected"
# Prints
#   ok 1 - TextGrid is selected
{% endhighlight %}

Similar to [`@ok`](#ok), this procedure also generates a test line, but the
value of the first argument is not interpreted as a boolean, but executed as a
[formula string][formulas]. This will be passed to [the `Calculator...` command]
[calculator], and the test will pass if this results in a true value
(i.e., non-zero).

[formulas]: http://www.fon.hum.uva.nl/praat/manual/Formulas.html
[calculator]: http://www.fon.hum.uva.nl/praat/manual/Calculator___.html

#### skip: number, why$
{: #skip }

{% highlight praat %}
@skip: 2, "show test skipping"
@ok: 0, "counted as passing"
@ok: 0, "also counted as passing"
@ok: 0, "not counted as passing!"

@skip: undefined, "start a SKIP block"
for i to randomInteger(5, 10)
  @ok: 0, "counted as passing"
endfor
@end_skip()
@ok: 0, "not counted as passing!"
{% endhighlight %}

A test can be skipped if the test suite decides it does not make sense to run
it. A skipped test will be marked as passing regardless of their output, and the
test line that reports it will bear a special description with the `SKIP`
directive.

It might be desirable to simply wrap the test in a conditional block and never
run it in the first place, but that would mean test numbers would change. This
procedure makes it possible to mark tests as skipped while keeping the test
indices intact, which means [`@plan`](#plan) can still be used.

The first argument to [`@skip`](#skip) specifies the number of tests to skip,
while the second argument specifies the reason why they were skipped. If the
number of tests to skip is `undefined`, all tests until the next call of
[`@end_skip`](#end-skip) will be skipped.

#### end_skip
{: #end-skip }

{% highlight praat %}
@skip: undefined, "start a SKIP block"
for i to randomInteger(5, 10)
  @ok: 0, "counted as passing"
endfor
@end_skip()
@ok: 0, "not counted as passing!"
{% endhighlight %}

This procedure ends a SKIP block. If a previous call to [`@skip`](#skip) has
been made with an `undefined` number of tests to skip, tests following the call
to this procedure will no longer be skipped. Otherwise, this procedure has no
effect.

#### skip_all: why$
{: #skip-all }

{% highlight praat %}
@skip_all: "skip all the tests!"
for i to randomInteger(5, 10)
  @ok: 0, "counted as passing"
endfor
@end_skip() ; Ignored in this case!
@ok: 0, "ALSO counted as passing"
{% endhighlight %}

Similar to calling [`@skip`](#skip) with an undefined number of tests to skip,
calling this procedure will mark following tests as skipped. However, unlike
[`@skip`](#skip), the effects of this procedure are not affected by subsequent
calls to [`@end_skip`](#end-skip). Once called, _all_ remaining tests will be
skipped.

#### todo: number, why$
{: #todo }

{% highlight praat %}
@todo: 2, "show to-do tests"
@ok: 1, "passing a TODO test is good!"
@ok: 0, "failing one is OK too"
@ok: 0, "no longer OK!"

@todo: undefined, "start a TODO block"
for i to randomInteger(5, 10)
  @ok: randomInteger(0, 1), "All these are OK"
endfor
@end_todo()
@ok: 0, "no longer OK!"
{% endhighlight %}

An alternative to skipping tests is to mark them as to-do, which is useful for
example when the test is testing code that has not been written yet. Tests
marked as to-do will still be run, and their results will be accurately
reported. But unlike regular tests, failing a to-do test does not affect the
outcome of the test suite. Passing them is a nice bonus.

Using this feature, a test can be written when a bug is discovered even if the
bug has still not been fixed. This not only works as a reminder that the bug is
there, but it also has the benefit that its result will change as soon as the
bug has been fixed (even if the solution was unintentional).

Like with [`@skip`](#skip), the first argument states the number of tests to
marks as to-do, while the second one gives them a common description. If the
number of tests is `undefined`, a TODO block begins and lasts until the next
call to [`@end_todo`](#end-todo).

#### end_todo
{: #end-todo }

{% highlight praat %}
@todo: undefined, "start a TODO block"
for i to randomInteger(5, 10)
  @ok: randomInteger(0, 1), "All these are OK"
endfor
@end_todo()
@ok: 0, "no longer OK!"
{% endhighlight %}

Similar to [`@end_skip`](#end-skip), this procedure finishes a TODO block. If
there has been a prior call to [`@todo`](#todo) with an `undefined` number of
tests, tests following this procedure will no longer be marked as to-do.
Otherwise, this procedure has no effect.

### `more.proc`

All the procedures made available by `simple.proc` are also available through
`more.proc`, such that tests written using `simple.proc` can be executed with
`more.proc` instead without changing the source code at all.

The procedures described below are available exclusively using `more.proc`.

#### is
{: #is }

{% highlight praat %}
a = 1
@is: a, 1, "is one"
# Prints
#   ok 1 - is one

a += 1
@is: a, 1, "is one"
# Prints
#   not ok 2 - is one
#   Failed test 'is one'
#          got: 2
#     expected: 1
{% endhighlight %}

The main difference between `simple.proc` and `main.proc` is that the
procedures in the latter try to provide better diagnostics for failing tests.
With the simple _ok_-style procedures, this diagnostic cannot be any more than
the state of the test. The new _is_-style of tests provide more information
about the existing and the expected outcome of the test, and allow for much more informative error messages.

`@is` takes a numeric value and its expected outcome (as well as a test
message), and tests both for equality.

#### is$
{: #is-string }

{% highlight praat %}
a$ = ""
@is$: a$, "", "is empty"
# Prints
#   ok 1 - is empty

a$ = "hello"
@is$: a$, "", "is empty"
# Prints
#   not ok 2 - is empty
#   Failed test 'is empty'
#          got: "hello"
#     expected: ""
{% endhighlight %}

Like [`@is`](#is), but tests string values.

#### isnt
{: #isnt }

{% highlight praat %}
a = 1
@isnt: a, 0, "not zero"
# Prints
#   ok 1 - not zero

a -= 1
@isnt: a, 0, "not zero"
# Prints
#   not ok 2 - not zero
#   Failed test 'not zero'
#          got: 0
#     expected: anything else
{% endhighlight %}

Like [`@is`](#is), but tests what a numeric value is _not_.

#### isnt$
{: #isnt-string }

{% highlight praat %}
a$ = "hello"
@isnt$: a$, "", "not empty"
# Prints
#   ok 1 - is empty

a$ = ""
@isnt$: a$, "", "not empty"
# Prints
#   not ok 2 - not empty
#   Failed test 'not empty'
#          got: ""
#     expected: anything else
{% endhighlight %}

Like [`@isnt`](#isnt), but tests string values.

#### cmp_ok
{: #cmp-ok }

{% highlight praat %}
a = -1
@cmp_ok: a, "<", 0, "is negative"
# Prints
#   ok 1 - is negative

a += 2
@cmp_ok: a, "<", 0, "is negative"
# Prints
#   not ok 2 - is negative
#   Failed test 'is negative'
#     '1'
#         <
#     '0'
{% endhighlight %}

The first three arguments in this case are a numeric value, a string
representing an operation to test, and a second numeric value. The result of
the test is the result of applying that operator to both values.

#### cmp_ok$
{: #cmp-ok-string }

{% highlight praat %}
a$ = "alpha"
@cmp_ok$: a$, "<", "beta", "comes first"
# Prints
#   ok 1 - comes first

a$ = "gamma"
@cmp_ok$: a$, "<", "beta", "comes first"
# Prints
#   not ok 2 - comes first
#   Failed test 'comes first'
#     'gamma'
#         <
#     'beta'
{% endhighlight %}

Like [`@cmp_ok`](#cmp-ok), but tests string values.

#### ok_exists
{: #ok-exists }

{% highlight praat %}
id = Create TextGrid: "test", 0, 1, "tiers", ""
@ok_exists: id, "object exists"
# Prints
#   ok 1 - object exists

Remove
@ok_exists: id, "object exists"
# Prints
#   not ok 2 - object exists
#   Failed test 'object exists'
#     object '1' doesn't exist
{% endhighlight %}

Checks whether an object with the specified ID exists in the Objects list.

#### no_object
{: #no-object }

{% highlight praat %}
id = undefined
@no_object: id, "no object"
# Prints
#   ok 1 - no object

id = Create TextGrid: "test", 0, 1, "tiers", ""
@no_object: id, "no object"
# Prints
#   not ok 2 - no object
#   Failed test 'no object'
#     object '1' exists
{% endhighlight %}

Like [`@ok_exists`](#ok-exists), but checks that a given object _does not_
exist.

#### ok_selected
{: #ok-selected }

{% highlight praat %}
id = Create TextGrid: "test", 0, 1, "tiers", ""
@ok_selected: id, "object is selected"
# Prints
#   ok 1 - object is selected

minusObject: id
@ok_selected: id, "object is selected"
# Prints
#   not ok 2 - object is selected
#   Failed test 'object is selected'
#     object '1' is not selected

removeObject: id
@ok_selected: id, "object is selected"
# Prints
#   not ok 3 - object is selected
#   Failed test 'object is selected'
#     object '1' doesn't exist
{% endhighlight %}

Checks whether an object with the specified ID exists in the Objects list and
is currently selected.

#### ok_unselected
{: #ok-unselected }

{% highlight praat %}
id = Create TextGrid: "test", 0, 1, "tiers", ""
minusObject: id
@ok_unselected: id, "object is not selected"
# Prints
#   ok 1 - object is not selected

selectObject: id
@ok_unselected: id, "object is not selected"
# Prints
#   not ok 2 - object is not selected
#   Failed test 'object is not selected'
#     object '1' is selected

removeObject: id
@ok_unselected: id, "object is not selected"
# Prints
#   not ok 3 - object is not selected
#   Failed test 'object is not selected'
#     object '1' doesn't exist
{% endhighlight %}

Like [`@ok_selected`](#ok-selected), but checks that a given object exists
and _is not_ selected.

#### is_deeply
{: #is-deeply }

{% highlight praat %}
id[1] = Create TextGrid: "test", 0, 1, "tiers", ""
id[2] = Copy: "copy"
@is_deeply: id[1], id[2], "same objects"
# Prints
#   ok 1 - same objects

Insert point tier: 1, "difference"
@is_deeply: id[1], id[2], "same objects"
# Prints
#   not ok 2 - same objects
#   Failed test 'same objects'
#         objects
#     1. TextGrid test
#         and
#     2. TextGrid copy
#         are not the same

removeObject: id[1]
@is_deeply: id[1], id[2], "same objects"
# Prints
#   not ok 3 - same objects
#   Failed test 'same objects'
#     '1'
#         doesn't exist but
#     2. TextGrid copy
#         does
{% endhighlight %}

Checks whether two objects specified by IDs are the same or not. Additional
checks for whether the objects exist or not are also made.

#### pass
{: #pass }

{% highlight praat %}
@pass: "automatic pass"
# Prints
#   ok 1 - automatic pass
{% endhighlight %}

Automatically pass a test. This can be useful if a test is the result of a
complicated process not easily reduced to one of the procedures above.

#### fail
{: #fail }

{% highlight praat %}
@fail: "automatic fail"
# Prints
#   not ok 1 - automatic fail
{% endhighlight %}

Like [`@pass`](#pass), but automatically marks the test as failing.

#### BAIL_OUT
{: #bail-out }

{% highlight praat %}
@BAIL_OUT: "catastrophic failure!"
# Prints
#   Bail out! catastrophic failure!
{% endhighlight %}

If you realise that testing after a given point is futile, you can call this
to aborts the test suite altogether.
