---
layout: page
group: plugin
title: colour
project: https://gitlab.com/cpran/plugin_colour
pid:
description:
  short: offers standard alternatives to Praat's native colour format
---
{% include JB/setup %}

Praat uses a rather unorthodox approach to define colours: red, green and
blue components have to be provided in a scale from 0 to 1, in which 0
equals to absense of a component.

This plugin offers conversions from standard colour formatting to Praat's
idiosyncratic format. In particular, this plugin parses hexadecimal, RGB
and HSV formats. To do so, it uses a series of procedures to convert
hexadecimal and HSV formats into RGB, and then from RGB to Praat's format.

When the plugin is installed, several new commands become available in the
Picture window, under the World and Pen menu. These commands can be used
manually or they can be intergrated directly into scripts by the means of
runScript.

Besides the colour formatting, these new commands receive the same
arguments than the original commands it aims to emulate.

## Installation

Install using [CPrAN][]:

    cpran install colour

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_colour/repository/archive.zip
[cpran]:   http://cpran.net

## Usage

~~~~
include ../../plugin_colour/procedures/rainbow.proc

@rainbow: 10, 50, 50
~~~~

## Requirements:

* [`utils`](/plugins/utils)
