---
layout: page
group: pod
title: list
description:
  short: List all known CPrAN plugins
---
{% include JB/setup %}

# NAME

**list** - List all known CPrAN plugins

# SYNOPSIS

cpran list \[options\]

# DESCRIPTION

List plugins available through the CPrAN catalog.

**list** will show a list of all plugins available to CPrAN.

# EXAMPLES

    # Show all available plugins
    cpran list

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
* [CPrAN::Command::remove]({{ BASE_PATH }}/docs/commands/remove)
* [CPrAN::Command::search]({{ BASE_PATH }}/docs/commands/search)
* [CPrAN::Command::show]({{ BASE_PATH }}/docs/commands/show)
* [CPrAN::Command::test]({{ BASE_PATH }}/docs/commands/test)
* [CPrAN::Command::update]({{ BASE_PATH }}/docs/commands/update)
* [CPrAN::Command::upgrade]({{ BASE_PATH }}/docs/commands/upgrade)
