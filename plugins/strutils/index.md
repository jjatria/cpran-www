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

A Strings object in Praat is an ordered list of strings that is most commonly
used to represent either lists of files or directories in disk (as returned
by the `Create Strings as file list...` and `Create Strings as directory list...` standard Praat commands), or the lines of a text file that was read with the `Read Strings from raw text file...` command.

“strutils” provides some new ways to create Strings (including the possibility of creating an empty Strings object, as well as making fully-specified file and directory lists), and some commands to manipulate existing objects.

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
