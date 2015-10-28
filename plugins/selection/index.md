---
layout: page
group: plugin
title: selection
project: https://gitlab.com/cpran/plugin_selection
pid: 2841
description:
  short: procedures to manage Praat selections
---
{% include JB/setup %}

The file [selection.proc][selection] defines a set of procedures to try to
make it easier to manage the selection of objects in Praat. It is an attempt at
providing some sort of informal API of sorts to save various selections, restore
them at will, modify them, etc.

[selection]: https://gitlab.com/cpran/plugin_selection/blob/master/procedures/selection.proc

## Installation

Install using [CPrAN][]:

    cpran install selection

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_selection/repository/archive.zip
[cpran]:   http://cpran.net

## Usage

~~~~
include ../../plugin_selection/procedures/selection.proc
~~~~

## Overview

Praat does not allow for the creation of custom object types, so it was
necessary to generate some abstraction of a selection that could be represented
using the existing object types. A **selection table** is a object of type
`Table` that represents a given selection. The procedures provide ways to
generate them based on the existing selection, to create new ones procedurally,
and to make them either from subsets, or as combinations of existing tables.

A **selection table** is simply a `Table` that contains the following fields:

* `type`, holding the type of a given object as a string
* `name`, holding the name of a given object as a string
* `n`, a placeholder variable holding the value `1`
* `id`, holding the id number of the corresponding object

**Any** `Table` that contains _at least_ these columns will be considered a
**selection table**, and can be used with these procedures.

Almost every procedure here uses **selection tables** to manage the selection,
with two exceptions: [saveSelection()][saveselection] and
[restoreSelection()][restoreselection].

[saveselection]: https://gitlab.com/cpran/plugin_selection/wikis/home#saveselection
[restoreselection]: https://gitlab.com/cpran/plugin_selection/wikis/home#restoreselection

Below, all procedures are explained in an order that will hopefully make it
easier to learn how to use them.

Please see [the documentation](https://gitlab.com/cpran/plugin_selection/wikis/home)
for more detailed information on how to use these procedures.

## Requirements:

* [`utils`](/plugins/utils)
