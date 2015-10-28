---
layout: page
group: plugin
title: serialise
project: https://gitlab.com/cpran/plugin_serialise
pid: 2842
description:
  short: read/write JSON or YAML Praat objects
---
{% include JB/setup %}

This plugin allows for the serialisation and de-serialisation of Praat objects
using JSON or YAML standards.

See [the troubleshooting page][trouble] for help with some common issues.

[trouble]: https://gitlab.com/cpran/plugin_serialise/wikis/home#troubleshooting

## Installation

Install using [CPrAN][]:

    cpran install serialise

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_serialise/repository/archive.zip
[cpran]:   https://cpran.net

Requirements
------------

* Perl >= 5.010
  * Path::Class
  * Readonly
  * YAML::XS
  * JSON
  * File::HomeDir
  * Try::Tiny
* [`utils`](/plugins/utils)
* [`selection`](/plugins/selection)
