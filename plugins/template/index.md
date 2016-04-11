---
layout: page
group: plugin
title: template
project: https://gitlab.com/cpran/plugin_template
pid: ~
description:
  short: a blank template for you to modify
---
{% include JB/setup %}

This is a blank template with a model directory and file structure that you can
use to create your own plugins. The structure is modelled after that in most
other plugins.

Although you are free to change it in whatever way you want, please consider
leaving it as it is: a [common directory structure][structure] is what allows
most other plugins to interact with one another in predictable ways.

[structure]: http://cpran.net/docs/plugins/#a-common-directory-structure

Although you can install this plugin as is, a more common way to use it is with
the [`create`][create] CPrAN command.

## Installation

Install using [CPrAN][]:

    cpran install template

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_template/repository/archive.zip
[cpran]:   http://cpran.net

Requirements
------------

* None

[create]: http://cpran.net/docs/commands/create
