---
layout: page
group: command
title: update
description:
  short: Update the catalog of CPrAN plugins
---
{% include JB/setup %}

## Synopsis

    cpran update [options] [arguments]

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

`fetch_descriptor()`

  : Fetches the descriptor of a plugin and writes it into an appropriately named
    file in the specified directory.

    Returns the serialised downloaded descriptor.

`list_projects()`

  : Provided with a list of plugin search terms, it returns a list of serialised
    plugin objects. If the provided list is empty, it returns all the plugins it
    can find in the CPrAN group.

## Options

`--verbose`

  : Increase verbosity of output.

## See also

* [CPrAN][cprandoc]
* [CPrAN::Plugin][plugin]
* [CPrAN::Command::create][create]
* [CPrAN::Command::deps][deps]
* [CPrAN::Command::init][init]
* [CPrAN::Command::install][install]
* [CPrAN::Command::list][list]
* [CPrAN::Command::remove][remove]
* [CPrAN::Command::search][search]
* [CPrAN::Command::show][show]
* [CPrAN::Command::test][test]
* [CPrAN::Command::upgrade][upgrade]

[cpran plugin]: {{ BASE_PATH }}/docs/plugins/cpran
[cprandoc]: {{ BASE_PATH }}/docs/cpran
[plugin]:   {{ BASE_PATH }}/docs/plugins
[create]:   {{ BASE_PATH }}/docs/commands/create
[deps]:     {{ BASE_PATH }}/docs/commands/deps
[init]:     {{ BASE_PATH }}/docs/commands/init
[install]:  {{ BASE_PATH }}/docs/commands/install
[list]:     {{ BASE_PATH }}/docs/commands/list
[remove]:   {{ BASE_PATH }}/docs/commands/remove
[search]:   {{ BASE_PATH }}/docs/commands/search
[show]:     {{ BASE_PATH }}/docs/commands/show
[test]:     {{ BASE_PATH }}/docs/commands/test
[update]:   {{ BASE_PATH }}/docs/commands/update
[upgrade]:  {{ BASE_PATH }}/docs/commands/upgrade
