---
layout: page
group: plugin
title: tap
project: https://gitlab.com/cpran/plugin_tap
description:
  short: "a full implementation of the Test Anything Protocol"
---
{% include JB/setup %}

This plugin offers a more complete implementation of the [Test Anything
Protocol][tap] than the one previously made available by its predecessor,
the [testsimple][] plugin. In this case, the main inspiration was the
[Test::More](https://metacpan.org/pod/Test::More) CPAN module.

This plugin should be installed automatically by running `cpran init` in
a new installation of CPrAN, since most other plugins depend on it for
testing.

It has been written so that existing tests written using testsimple can be
used as they are with this plugin, without having to change anything but the
procedures that are included.

However, there are other benefits to using this plugin instead of the old
one. In particular, the new family of test procedures illustrated below
provide more meaningful diagnostic messages with failing tests.

[tap]: http://testanything.org
[testsimple]: http://cpran.net/plugins/testsimple

## Installation

Install using [CPrAN][]:

    cpran install tap

You can download an [archive][] of the latest version for manual installation.
You can manually install the plugin just like any other [Praat plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_tap/repository/archive.zip
[cpran]:   http://cpran.net

## Synopsis

{% highlight praat linenos %}
include /path/to/tap/more.proc

# Abort testing in critical case
if cricital_failure
  @bail_out("Testing is pointless!")
endif

# Plan your test suite
@no_plan()
# or @plan(total_tests) if you know how many tests you'll run

# Run your tests

# Test for numeric equality
@is:   1, 1, "one is equal to one"
@isnt: e, undefined, "e is not undefined"

# Test for string equality
@is$:   "hello", "hello", "hello is hello"
@isnt$: praatVersion$, string$(undefined), "version is defined"

# Test using regular expressions
@like:   "abba", "[ab]{2}", "one string is like the other"
@unlike: "baba", "^a[ba]*", "strings are not alike"

# Test with other comparisons
@cmp_ok:  54, ">", 10, "use any operators you want"
@cmp_ok$: "foo", "<", "bar", "foo precedes bar"

# Print diagnostic messages
@is: 0, undefined, "a failing test"
if !ok.value
  @diag: "Current status: " + status$
endif

# Test objects
@ok_exists: id, "object with that ID exists"
@no_object: id, "no object with that ID"

@ok_selected:   id, "that object is selected"
@ok_unselected: id, "object is not selected"

@is_deeply: id[1], id[2], "both objects are identical"

# Make your own tests
if a and (b > c) or (m != a + x)
  @pass: "automatic pass"
else
  @fail: "automatic fail"
endif

# Mark the end of your suite
@done_testing()
{% endhighlight %}

## Requirements

None
