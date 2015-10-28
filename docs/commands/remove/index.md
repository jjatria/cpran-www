---
layout: page
group: pod
title: remove
description:
  short: Remove installed CPrAN plugins
---
{% include JB/setup %}

# NAME

**remove** - Remove installed CPrAN plugins

# SYNOPSIS

cpran remove \[options\] \[arguments\]

# DESCRIPTION

Deletes a CPrAN plugin that has been installed.

Arguments to **remove** must be at least one and optionally more plugin names to
remove. For each named passed as argument, all contents of the directory named
"plugin\_<name>" will be removed from disk.

# EXAMPLES

    # Remove some plugins
    cpran remove oneplugin otherplugin
    # Do not ask for confirmation
    cpran remove -y oneplugin

# OPTIONS

- **--yes, -y**

    Assumes yes for all questions.

- **--force**

    Tries to work around problems.

- **--debug**

    Print debug messages.

- **--verbose**
- **--quiet**
- **--cautious**

# METHODS

# AUTHOR

José Joaquín Atria <jjatria@gmail.com>

# LICENSE

Copyright 2015 José Joaquín Atria

This program is free software; you may redistribute it and/or modify it under
the same terms as Perl itself.

# SEE ALSO

* [CPrAN]({{ BASE_PATH }}/docs/cpran)
* [CPrAN::Plugin]({{ BASE_PATH }}/docs/plugin)
* [CPrAN::Command::install]({{ BASE_PATH }}/docs/commands/install)
* [CPrAN::Command::search]({{ BASE_PATH }}/docs/commands/search)
* [CPrAN::Command::show]({{ BASE_PATH }}/docs/commands/show)
* [CPrAN::Command::test]({{ BASE_PATH }}/docs/commands/test)
* [CPrAN::Command::update]({{ BASE_PATH }}/docs/commands/update)
* [CPrAN::Command::upgrade]({{ BASE_PATH }}/docs/commands/upgrade)
