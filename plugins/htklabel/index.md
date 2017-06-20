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

Label files used by HTK/HTS and related software packages represent a similar
data structure as a Praat TextGrid object. The scripts in this plugin allow
conversions to and from label files and TextGrid objects.

Multiple levels within a label file are mapped to multiple interval tiers
within a TextGrid object; while multiple alternatives result in the creation
of as many different TextGrid objects.

In the conversion from TextGrid to label files, only non-empty labels are
taken into account. Label files need a specified start and end time in each
line in order to be properly converted.

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
