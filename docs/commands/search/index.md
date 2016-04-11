---
layout: page
group: command
title: search
description:
  short: Search CPrAN plugins
---
{% include JB/setup %}

## Synopsis

    cpran search [options] [arguments]

## Description

Searches both the local and remote catalogs of CPrAN plugins.

The argument to **search** must be a single regular expression. Currently,
**search** tries to match it on the plugni's name, and returns a list of all
those who do.

When executed directly, it will print information on the matched plugins,
including their name, version, and a short description. If searching the locally
installed plugins, both the local and the remote versions will be displayed.

## Examples

    # Show all available plugins
    cpran search .*
    # Show installed plugins with the string "utils" in their name
    cpran search -i utils

## Options

`--installed`

  : Search the local (installed) CPrAN catalog.

`--debug`

  : Print debug messages.

## Methods

`_match()`

  : Performs the search agains the specified fields of the plugin.

`_add_output_row()`

  : Generates and adds a line for the output table. This subroutine internally calls
    `make_output_row()` and attaches it to the table.

`_make_output_row()`

  : Generates the appropriate line for a single plugin specified by name. Takes the
    name as an argument, and returns a list suitable to be plugged into a
    Text::Table object.

    The output depends on the current options: if **--installed** is enabled, the
    returned list will have both the local and the remote versions.

## See also

* [CPrAN][cprandoc]
* [CPrAN::Plugin][plugin]
* [CPrAN::Command::create][create]
* [CPrAN::Command::deps][deps]
* [CPrAN::Command::init][init]
* [CPrAN::Command::install][install]
* [CPrAN::Command::list][list]
* [CPrAN::Command::remove][remove]
* [CPrAN::Command::show][show]
* [CPrAN::Command::test][test]
* [CPrAN::Command::update][update]
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
