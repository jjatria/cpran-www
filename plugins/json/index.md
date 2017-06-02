---
layout: page
group: plugin
title: json
project: https://gitlab.com/cpran/plugin_json
pid: ~
description:
  short: read and write valid JSON using Praat
theme:
  name: cpran
---
{% include JB/setup %}

[JSON][] is a standard for data serialisation that has seen
widespread use in the exchange of arbitrarily complex data
structures across all sorts of software tools. It allows you to
write these data in a format that is not application-dependant,
and share them with whatever you choose.

The JSON plugin provides Praat with a much needed interface to
produce JSON output from internal data structures. It uses Table
objects as dictionaries and Strings objects as lists, and provides
procedures to easily print the contents of these as JSON-compliant
output.

The methods included allow for objects to reference other
objects, making it possible to represent arbitrarily
complex data structures.

Additionally, this plugin includes procedures to interact with
Table objects as if they were a dictionary, in a way that
complements the methods offered by the `array.proc` file in the
["strutils"][strutils] plugin.

[json]: http://json.org
[strutils]: http://cpran.net/plugins/strutils

Installation
------------

Install using [CPrAN][]:

    cpran install json

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_json/repository/archive.zip
[cpran]:   http://cpran.net

Requirements
------------

* `utils`
* `strutils`
