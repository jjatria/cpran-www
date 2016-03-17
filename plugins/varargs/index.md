---
layout: page
group: plugin
title: varargs
project: https://gitlab.com/cpran/plugin_varargs
pid: ~
description:
  short: write variadic procedures in Praat
theme:
  name: cpran
---
{% include JB/setup %}

This plugin provides an interface to write procedures that take
a variable number of arguments, and can specify default values.

{% highlight praat linenos %}
include ../procedures/varargs.proc

# Write the calls with `call` instead of `@`
# but pass arguments separated with commas
# and use the special "keyword" `varargs`
call varargs greet
call varargs greet: "Paul"
call varargs greet: "Goodbye", "David"

# Define your procedures
procedure greet ()
  # Register the valid signatures
  .nil = 1
  .s   = 1
  .ss  = 1

  # Specify any default values
  .ing$  = "Hello"
  .name$ = "World"
endproc

# Implement _all_ signatures
procedure greet.nil ()
  @greet.ss: greet.ing$, greet.name$
endproc

procedure greet.s: .name$
  @greet.ss: greet.ing$, .name$
endproc

procedure greet.ss: .greet$, .name$
  appendInfoLine: .greet$, ", ", .name$, "!"
endproc
{% endhighlight %}

Installation
------------

Install using [CPrAN][]:

    cpran install varargs

You can download an [archive][] of the latest version for manual installation,
but you'll have to also manually install [the dependencies](#requirements)
yourself. You can manually install the plugin just like any other [Praat
plugin][plugins].

[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html
[archive]: https://gitlab.com/cpran/plugin_varargs/repository/archive.zip
[cpran]:   http://cpran.net

Requirements
------------

* None
