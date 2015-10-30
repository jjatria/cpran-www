---
layout: page
group: plugin
title: strutils
project: https://gitlab.com/cpran/plugin_strutils
pid: 3252
description:
  short: a collection of basic Strings utilities
---
{% include JB/setup %}

This plugin defines a set of Strings utilities:

* Create empty Strings
* Extract strings
* Create Strings as file list (full path)
* Create Strings as file list (recursive)
* Create Strings as directory list (full path)
* Create Strings as directory list (recursive)
* Replace strings
* Find in Strings
* Generic sort for Strings

## Installation

Install using [CPrAN][]:

    cpran install strutils

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_strutils/repository/archive.zip
[cpran]:   https://cpran.net

## Requirements

* [`utils`](/plugins/utils)
* [`selection`](/plugins/selection)
