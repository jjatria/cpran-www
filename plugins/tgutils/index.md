---
layout: page
group: plugin
title: tgutils
project: https://gitlab.com/cpran/plugin_tgutils
pid: 2915
description:
  short: a collection of basic TextGrid utilities
---
{% include JB/setup %}

This plugin defines a set of TextGrid utilities:

* Count points in range
* Find labels from beginning or end
* Equalize tier durations
* Explode TextGrid intervals
* Move boundaries to zero-crossings
* Find non-overlapping intervals
* Save as Audacity labels

## Installation

Install using [CPrAN][]:

    cpran install tgutils

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_tgutils/repository/archive.zip
[cpran]:   https://cpran.net

## Requirements

* [`utils`](/plugins/utils)
* [`selection`](/plugins/selection)
