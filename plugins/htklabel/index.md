---
layout: page
group: plugin
title: htklabel
project: https://gitlab.com/cpran/plugin_htklabel
pid: 3546336
description:
  short: Read and write HTK/HTS label files
---
{% include JB/setup %}

This plugin implements Hirst and DeLooze's utterance-specific two-pass Pitch
estimation algorithm.

## Installation

Install using [CPrAN][]:

    cpran install htklabel

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_htklabel/repository/archive.zip
[cpran]:   https://cpran.net

## Requirements

* [`utils`](/plugins/utils)
* [`varargs`](/plugins/varargs)
* [`printf`](/plugins/printf)
* [`selection`](/plugins/selection)
* [`strutils`](/plugins/strutils)
