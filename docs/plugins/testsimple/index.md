---
layout: page
group: pod
title: testsimple
---
{% include JB/setup %}

This plugin implements a simple framework to produce a TAP stream. TAP stands
for the "Test Anything Protocol", and according to [its website][tap], it "is a
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

### `test_simple.proc`

#### plan: tests
{: #plan }

    # Plan 10 tests
    @plan: 10
    # Prints out
    #   1..10

Every TAP stream must either begin or end with a plan line, which specifies how
may tests will run, or have run. This is a safeguard in case your test file dies
silently in the middle of its run.

For **testsimple**, it is an error to begin a test suite without having first
specified a plan by calling this procedure. In the case that a test suite does
not know how many tests will be run, this must be stated explicitly with
[`@no_plan`](#no-plan).

#### no_plan
{: #no-plan }

    # If you do not know how many tests you'll run
    @no_plan()

Sometimes a test suite will have an undetermined number of tests. In this case,
**testsimple** requires this to be explicitly stated before the first test takes
place by calling this procedure. Every test script using this plugin should
begin with a call to this procedure or to [`@plan`](#plan).

#### done_testing
{: #done-testing }

    @done_testing()

This procedure marks the end of the testing suite. It generates no output if a
plan line has already been printed (with [`@plan`](#plan)), but is necessary
when [`@no_plan`](#no-plan) is in use.

It is an error to call this procedure more than once, or to call it before
either of the planning procedures has been called.

#### ok: test, description$
{: #ok }

    Create TextGrid: "test", 0, 1, "tiers", ""
    @ok: selected("TextGrid"), "TextGrid is selected"
    # Prints
    #   ok 1 - TextGrid is selected

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

    Create TextGrid: "test", 0, 1, "tiers", ""
    @ok_formula: "selected(""TextGrid"")", "TextGrid is selected"

Similar to [`@ok`](#ok), this procedure also generates a test line, but the
value of the first argument is not interpreted as a boolean, but executed as a
[formula string][formulas]. This will be passed to
[the `Calculator...` command][calculator], and the test will pass if this is a
true value (i.e., non-zero).

[formulas]: http://www.fon.hum.uva.nl/praat/manual/Formulas.html
[calculator]: http://www.fon.hum.uva.nl/praat/manual/Calculator___.html

#### skip: number, why$
{: #skip }

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

    @skip: undefined, "start a SKIP block"
    for i to randomInteger(5, 10)
      @ok: 0, "counted as passing"
    endfor
    @end_skip()
    @ok: 0, "not counted as passing!"

This procedure ends a SKIP block. If a previous call to [`@skip`](#skip) has
been made with an `undefined` number of tests to skip, tests following the call
to this procedure will no longer be skipped. Otherwise, this procedure has no
effect.

#### skip_all: why$
{: #skip-all }

    @skip_all: "skip all the tests!"
    for i to randomInteger(5, 10)
      @ok: 0, "counted as passing"
    endfor
    @end_skip() ; Ignored in this case!
    @ok: 0, "ALSO counted as passing"

Similar to calling [`@skip`](#skip) with an undefined number of tests to skip,
calling this procedure will mark following tests as skipped. However, unlike
[`@skip`](#skip), the effects of this procedure are not affected by subsequent
calls to [`@end_skip`](#end-skip). Once called, _all_ remaining tests will be
skipped.

#### todo: number, why$
{: #todo }

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

    @todo: undefined, "start a TODO block"
    for i to randomInteger(5, 10)
      @ok: randomInteger(0, 1), "All these are OK"
    endfor
    @end_todo()
    @ok: 0, "no longer OK!"

Similar to [`@end_skip`](#end-skip), this procedure finishes a TODO block. If
there has been a prior call to [`@todo`](#todo) with an `undefined` number of
tests, tests following this procedure will no longer be marked as to-do.
Otherwise, this procedure has no effect.
