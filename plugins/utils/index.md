---
layout: page
group: plugin
title: utils
project: https://gitlab.com/cpran/plugin_utils
pid: 2840
description:
  short: a collection of basic utilities to facilitate scripting
---
{% include JB/setup %}

This plugin provides a series of procedures to facilitate some scripting tasks:

* Directory and file GUI selectors for initial forms

* A method to require specific versions of Praat

* Procedures for format-free date manipulation

* Procedures to safely create temporary files and directories

* Procedures for try/catch-style programming

* Count string occurrences with or without regular expressions

* `split`

* `pwgen`

* `zeropad`

* `toLower`

* `toUpper`

## Installation

Install using [CPrAN][]:

    cpran install utils

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_utils/repository/archive.zip
[cpran]:   http://cpran.net

Requirements
------------

* [`testsimple`](/plugins/testsimple)
