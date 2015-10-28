---
layout: page
group: plugin
title: vieweach
project: https://gitlab.com/cpran/plugin_vieweach
pid: 3262
description:
  short: a set of customizable procedures to iterate through sets of objects
---
{% include JB/setup %}

**See [the wiki][] for the complete documentation**

[the wiki]: https://gitlab.com/cpran/plugin_vieweach/wikis/home

This plugin provides features for iterating through an arbitrarily complex
sets of objects. They are provided both as procedures, to make it easier to
write scripts that use those iterative features, and as scripts, to encapsulate
the most commonly needed applications.

## Installation

Install using [CPrAN][]:

    cpran install vieweach

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_vieweach/repository/archive.zip
[cpran]:   https://cpran.net

## Description

The procedures are written in such a way that their behaviour can be almost
completely redefined by means of procedure redefinition, which is a way to
implement something akin to code hooks in Praat.

In simple terms, this means that the code that gets executed at specific times
during the iteration are designed to be modified. This makes the procedures
incredibly versatile.

## Procedures

The first set of procedures ([`for_each.proc`][]) defines the core iterative
features, which uses [`Table`][] and `Strings` objects to represent sets of objects
to iterate over. This makes it possible to seamlessly iterate over objects that
reside in the Object list, on disk, or in a combination of both.

The second set of procedures ([`view_each.proc`][]) demonstrates one possible
application of `for_each` to allow for easy navigation both back and forth over
the specified (sets of) objects, opening the appropriate editor window for each
when available.

[`table`]: https://gitlab.com/cpran/plugin_selection#overview
[`for_each.proc`]: http://gitlab.com/cpran/plugin_vieweach/blob/master/procedures/for_each.proc
[`view_each.proc`]: http://gitlab.com/cpran/plugin_vieweach/blob/master/procedures/view_each.proc

## Scripts

These two set of procedures are further packaged into two corresponding scripts:
[`for_each.praat`][] and [`view_each.praat`][].

The first one will execute a specified script during each iteration, and select
all the objects created over those iterations at the end. The script also makes
it possible to specify whether the iteration should be done directly over the
selected objects, by selecting one object per type for each iteration, or by
using the selected objects (either `Table` or `Strings` objects) as sets of
objects.

As an example, if told to iterate over the selected objects, and given a script
with the instructions

```praat
name$ = extractWord$(selected$(), " ")
Copy: name$
```

then the resulting selection after completion would be a copy of all the
initially selected objects.

The second comes in two flavours, and will iterate over either objects in the
[Object list][] or [on disk][] and provide an editor for each, if applicable. If
the selection includes only `Sound` and `TextGrid` objects, then the script will
automatically pair these for each iteration. The navigation over the objects is
robust enough to support the deletion of objects with no ill effects.

[`for_each.praat`]: http://gitlab.com/cpran/plugin_vieweach/blob/master/scripts/for_each.praat
[`view_each.praat`]: http://gitlab.com/cpran/plugin_vieweach/blob/master/scripts/view_each.praat
[object list]: http://gitlab.com/cpran/plugin_vieweach/blob/master/scripts/view_each.selected.praat
[on disk]: http://gitlab.com/cpran/plugin_vieweach/blob/master/scripts/view_each.from_disk.praat

## Customization

The provided scripts and the tests provide a good example of the versatility
made possible thanks to procedure redefinition. Take a look at the code for
ideas, or visit the wiki for the full documentation of the available hooks and
start writing your own scripts!

## Requirements

* [`selection`](/plugins/selection)
* [`strutils`](/plugins/strutils)
* [`utils`](/plugins/utils)
