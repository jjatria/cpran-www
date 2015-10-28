---
layout: page
group: pod
title: test
description:
  short: Run tests for the specified plugin
---
{% include JB/setup %}

# NAME

**test** - Run tests for the specified plugin

# SYNOPSIS

cpran test \[options\] plugin

# DESCRIPTION

Run tests for the specified plugins. When called on its own it will simply
report the results of the test suites associated with the given plugins.
When called from within CPrAN (eg. as part of the installation process), it
will only report success if all tests for all given plugins were successful.

# EXAMPLES

    # Run tests for the specified plugin
    cpran test plugin

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
* [CPrAN::Command::update]({{ BASE_PATH }}/docs/commands/update)
* [CPrAN::Command::upgrade]({{ BASE_PATH }}/docs/commands/upgrade)
