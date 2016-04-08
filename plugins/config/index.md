---
layout: page
group: plugin
title: config
project: https://gitlab.com/cpran/plugin_config
pid: ~
description:
  short: read structured data from a config file
theme:
  name: cpran
---
{% include JB/setup %}

This plugin provides a standard interface to read data from a config file.
The data is read into a hash (in Praat 6.0.16+) or into a Table representation
of the hash as a fallback method. This fallback can be forced to ensure a
predictable behaviour.

Configuration files as read by the procedure in this plugin support comments
(lead by hash characters). The separator string between keys and values is
also user specified, but defaults to ":".

{% highlight praat linenos %}
include ../procedures/config.proc

@config: "config.ini"
appendInfoLine: "Read ", config.length, " lines from config files"
{% endhighlight %}

Installation
------------

Install using [CPrAN][]:

    cpran install config

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_config/repository/archive.zip
[cpran]:   http://cpran.net

Requirements
------------

* None
