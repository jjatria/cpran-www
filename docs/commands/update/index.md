---
layout: page
group: command
title: update
description:
  short: Update the catalog of CPrAN plugins
---
{% include JB/setup %}

## Synopsis

cpran update \[options\] \[arguments\]

## Description

Updates the list of plugins known to CPrAN, and information about their latest
versions.

**update** can take as argument a list of plugin names. If provided, only
information about those plugins will be retrieved. Otherwise, a complete list
will be downloaded. This second case is the recommended use.

## Examples

    # Updates the entire catalog printing information as it goes
    cpran update -v
    # Update information about specific plugins
    cpran update oneplugin otherplugin

## Methods

- **fetch\_descriptor()**

    Fetches the descriptor of a plugin and writes it into an appropriately named
    file in the specified directory.

    Returns the serialised downloaded descriptor.

- **list\_projects()**

    Provided with a list of plugin search terms, it returns a list of serialised
    plugin objects. If the provided list is empty, it returns all the plugins it
    can find in the CPrAN group.

## Options

- **--verbose**

    Increase verbosity of output.

## See also

* [CPrAN]({{ BASE_PATH }}/docs/cpran)
* [CPrAN::Plugin]({{ BASE_PATH }}/docs/plugin)
* [CPrAN::Command::install]({{ BASE_PATH }}/docs/commands/install)
* [CPrAN::Command::remove]({{ BASE_PATH }}/docs/commands/remove)
* [CPrAN::Command::search]({{ BASE_PATH }}/docs/commands/search)
* [CPrAN::Command::show]({{ BASE_PATH }}/docs/commands/show)
* [CPrAN::Command::test]({{ BASE_PATH }}/docs/commands/test)
* [CPrAN::Command::upgrade]({{ BASE_PATH }}/docs/commands/upgrade)
