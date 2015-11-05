---
layout: page
group: command
title: test
description:
  short: Run tests for the specified plugin
---
{% include JB/setup %}

## Synopsis

cpran test \[options\] plugin

## Description

Run tests for the specified plugins. When called on its own it will simply
report the results of the test suites associated with the given plugins.
When called from within CPrAN (eg. as part of the installation process), it
will only report success if all tests for all given plugins were successful.

## Examples

    # Run tests for the specified plugin
    cpran test plugin

## See also

* [CPrAN]({{ BASE_PATH }}/docs/cpran)
* [CPrAN::Plugin]({{ BASE_PATH }}/docs/plugins)
* [CPrAN::Command::install]({{ BASE_PATH }}/docs/commands/install)
* [CPrAN::Command::remove]({{ BASE_PATH }}/docs/commands/remove)
* [CPrAN::Command::search]({{ BASE_PATH }}/docs/commands/search)
* [CPrAN::Command::show]({{ BASE_PATH }}/docs/commands/show)
* [CPrAN::Command::update]({{ BASE_PATH }}/docs/commands/update)
* [CPrAN::Command::upgrade]({{ BASE_PATH }}/docs/commands/upgrade)
