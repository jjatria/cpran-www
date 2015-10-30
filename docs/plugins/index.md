---
layout: page
group: pod
title: Plugins
description:
  short: What is a CPrAN plugin? How is it different from a Praat plugin? How do I make a new plugin?
---
{% include JB/setup %}

## Description

All package managers need a way to bundle the package that is to be distributed.
Praat already provides a convenient way to bundle sets of scripts that can be
distributed: plugins. That is why CPrAN is the "_plugin_ manager for Praat".

### Praat plugins

Praat makes very few assumptions as to what the contents of [a plugin][plugins]
need to be. In fact, the only requirement it has is that it resides in a
directory under the Praat [preferences directory][] whose name begins with
`plugin_`. Anything under that "plugin directory" will be considered part of the
plugin.

[preferences directory]: http://www.fon.hum.uva.nl/praat/manual/preferences_directory.html
[plugins]: http://www.fon.hum.uva.nl/praat/manual/plug-ins.html

Additionally, a file named `setup.praat` placed at the root of the plugin
directory will be executed automatically every time Praat is run. But then
again: Praat makes no assumptions as to the contents of this script, or even its
existence.

These are the only requirements for a Praat plugin.

### CPrAN plugins

A core principle of CPrAN is that any Praat plugin should be elligible for
registration and distribution, and that plugins that are compatible with CPrAN
should not _depend_ on CPrAN to run. This means that, a their core, CPrAN
plugins can only _add_ to the requirements outlined above.

The only thing that CPrAN requires of their plugins is a plugin _descriptor_. A
descriptor, as understood by CPrAN, is a file with metadata for the plugin
including information like its name, its current version, the name of its
maintainer, and a list of any requirements it might have.

This descriptor MUST be a properly formatted YAML file. You can look at [a
commented example][example descriptor] of a properly formatted descriptor.

[example descriptor]: https://gitlab.com/cpran/plugin_cpran/blob/master/doc/example.yaml

Additionally, there are two extra CPrAN features that you can make use of to
improve the functionality of your plugin, and its interoperability with other
plugins.

#### Separation between logic and interface

To make it easier for other plugins to make use of your plugin, it is
recommended that you make a distinction in the scripts that you write between
the logic of your scripts, and their interface.

Because of the way in which the Praat scripting language is designed, there are
some things that are easier to do with procedures and some things that are
easier to do with standalone scripts.

For example, procedures allow you to have access to the data they are
processing, and they make it possible to redefine part of their behaviour. While
having standalone scripts makes it easier to enforce a local scope for your
variables, which in turn makes it easier to implement recursive algorithms.

You can make use this to your advantage, by separating the part of your scripts
that common users need access to and whose only usable product is their result,
from the part of your scripts that takes care of the heavy lifting behind your
scripts and which might be used for other scripts.

CPrAN recommends the first to be called "scripts" (and given the
traditional `.praat` extension), and the second to be called "procedures" (and
given the `.proc` extension). That way your users will know that `.praat` files
are to be used as they are, while `.proc` files can be [included][include] into
their own work to build other things.

#### A common directory structure

To make it easier for users to [include][] your procedures into their own
plugins, and to bypass some of the limitations in Praat, it is recommended that
all plugins have a common directory structure.

[include]: http://www.fon.hum.uva.nl/praat/manual/Scripting_5_7__Including_other_scripts.html

The `setup.praat` file (if you have any) needs to be in the plugin root, as does
the plugin descriptor. But it is recommended that all your important files
reside in a subdirectory under your plugin root. This will not only help you to
keep things tidy, but it will also make it possible for your scripts
(particularly your procedures) to be included by others, and to be included by
procedures which _include other procedures of their own_.

Most plugins will have a `scripts` subdirectory with their scripts, but at the
very least, try to place your procedures into a `procedures` subdirectory. You
are free to place everything else anywhere you like.

#### Use automated tests

The final feature CPrAN adds is automated testing. This means that when a user
installs your plugin, CPrAN can make sure that the plugin is working as
expected, which will reduce the number of undetected bugs, and make it easier
for you to fix bugs and your users to know that they can trust in what you
wrote.

CPrAN uses the [Test Anything Protocol][tap] (TAP) for testing, and looks for
tests under a `t` subdirectory under your plugin root. By default, all files
with a `.t` extension under that directory SHOULD be considered to be tests and
run automatically by compliant [CPrAN clients][clients].

These tests are nothing fancy: they are simply Praat scripts (with a different
extension) that produce TAP output. In order to make it easier for you to write
these tests you can use the [`testsimple`][testsimple] plugin, but you can also
write it manually if you prefer.

[testsimple]: {{ BASE_PATH }}/plugins/testsimple

If no `t` subdirectory is found, no tests will be run. CPrAN will make a note of
this when your plugin is installed, but installation SHOULD proceed without
problems (fingers crossed!).

[tap]: testanything.org

## Registering a plugin

There is currently no streamlined process for registering a plugin with CPrAN,
but this does not mean that your plugin cannot be registered! Please
[contact us](mailto:jjatria@gmail.com) and we can take it from there.

## License

Copyright 2015 CPrAN Team

<span>Documentation</span>{: xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type" }
by [CPrAN Team](cpran.net){: xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName" rel="cc:attributionURL" }
is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/){: rel="license" }

## See also

* [CPrAN]({{ BASE_PATH }}/docs/cpran)
* [CPrAN Clients][clients]
* [CPrAN Commands]({{ BASE_PATH }}/docs/commands)

[clients]: {{ BASE_PATH }}/docs/clients
