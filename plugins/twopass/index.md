---
layout: page
group: plugin
title: twopass
project: https://gitlab.com/cpran/plugin_twopass
pid: 2844
description:
  short: a method for utterance-specific Pitch threshold estimation
---
{% include JB/setup %}

This plugin implements Hirst and DeLooze's utterance-specific two-pass Pitch
estimation algorithm.

## Installation

Install using [CPrAN][]:

    cpran install twopass

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_twopass/repository/archive.zip
[cpran]:   https://cpran.net

## Requirements

* [`utils`](/plugins/utils)
* [`selection`](/plugins/selection)
* [`strutils`](/plugins/strutils)
* [`vieweach`](/plugins/vieweach)
