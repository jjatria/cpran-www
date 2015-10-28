---
layout: page
title: CPrAN
tagline: The Praat plugin manager
---
{% include JB/setup %}

![CPrAN](/assets/images/text_logo-small.png)

A plugin manager for Praat
--------------------------

CPrAN allows you to [browse][search], [install][] and [remove][] Praat plugins
of all kinds. With it, you can also [keep up to date][upgrade] with the latest
releases of those plugins, and make sure that the plugins you install are
[always in working order][test].

[search]:  /docs/commands/search
[install]: /docs/commands/install
[remove]:  /docs/commands/remove
[upgrade]: /docs/commands/upgrade
[test]:    /docs/commands/test

To use CPrAN, you'll have to install it as you would normally with any other
Praat plugin. The current version is [written in Perl][perl client], so you'll
probably also need to install some other modules before you can use it.

[perl client]: clients/cpran

All you need to get up and running is explained in the [installation
instructions][install client].

[install client]: clients/cpran#installation

Once you are done, take a look at the documentation for [how to use the current
client][cpran], or read below for a quick overview. You can also take a look
at the [currently registered plugins][plugin list] to whet your appetite.

[cpran]: docs/cpran
[plugin list]: plugins

And if you are interested, you can read about the [rationale][] of the project.

[rationale]: 2015/03/18/rationale

### A quick sampler

Although future versions will probably have a GUI, to use the current version
of CPrAN, you'll have to use the command line. You can get to a command line
with one of the many terminal emulators in Linux, the Terminal app in Mac, or
by running `cmd` in Windows.

The text in the boxes below written with a `monospaced font` is text that you
should write into the command line.

#### First step

CPrAN connects to an online database of plugins, and stores a local copy of
that listing in your computer. That way it knows what the latest versions of
the different plugins are.

To refresh your local database, use the `update` command:

    cpran update

#### Explore the library

You can then get a listing of all the plugins with the `list` command:

    cpran list

You'll get a list of all the available plugins, with its name, version, and
a short description. The "local" column shows the version that you have
installed (or nothing, if it's not installed), and the "remote" column shows the
latest version since the last time you ran `update`.

Plugins that yuo have installed that are _not_ on CPrAN will also be listed, and
marked as such.

You can also search for specific terms with `search`:

    cpran search split
    cpran search utils sound

All terms will be interpreted as regular expressions (so you might have to
escape some special characters, or quote them). If you type in more than one
term, you can refine the search.

Once you've found a plugin that you are interested in, you can get more
information with the `show` command.

    cpran show utils

This'll show you much more deatailed information on the plugin, including its
name, version, maintainer, any requirements it might have, and a longer
description (if available).

#### Install new plugins

If you like what you see, you can install it with `install`:

    cpran install utils

When a plugin gets installed, it is automatically tested using Praat to make
sure that it works as expected in your own setup.

#### Manage installed plugins

If a new version of, say, "utils" is released, you can use `upgrade` to bring
your local copy up to speed:

    cpran upgrade

CPrAN will check all installed plugins for any that need upgrading, and ask
for you to confirm. If you'd like to upgrade a specific plugin, you can also
mention it specifically, like `cpran upgrade utils`.

When you are finished with a plugin, you can uninstall it with `remove`:

    cpran remove utils

That's it!
