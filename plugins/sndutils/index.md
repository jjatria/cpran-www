---
layout: page
group: plugin
title: sndutils
project: https://gitlab.com/cpran/plugin_sndutils
pid: 3508
description:
  short: a collection of basic Sound utilities
---
{% include JB/setup %}

This plugin defines a set of Sound utilities:

* Smart RMS normalisation
* Filter and center sounds

## Installation

Install using [CPrAN][]:

    cpran install sndutils

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_sndutils/repository/archive.zip
[cpran]:   https://cpran.net

## Requirements

* [`utils`](/plugins/utils)
* [`selection`](/plugins/selection)
