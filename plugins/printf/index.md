---
layout: page
group: plugin
title: printf
project: https://gitlab.com/cpran/plugin_printf
pid: ~
description:
  short: use printf-style commands for string formatting
theme:
  name: cpran
---
{% include JB/setup %}

This plugin provides `printf(3)`-style string formatting procedures
for Praat.

Installation
------------

Install using [CPrAN][]:

    cpran install printf

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_printf/repository/archive.zip
[cpran]:   http://cpran.net

Requirements
------------

* `varargs`
