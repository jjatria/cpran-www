---
layout: page
group: command
title: show
description:
  short: Show details for specified CPrAN plugins
---
{% include JB/setup %}

## Synopsis

    cpran show [options] [arguments]

## Description

Shows the descriptor of specified plugins. Depending on the options used,
it can be used to display information about the latest available version,
or the currently installed version.

Arguments to search must be at least one and optionally more plugin names
whose descriptors will be displayed.

## Examples

    # Show details of a plugin
    cpran show oneplugin
    # Show the descriptors of many installed plugins
    cpran show -i oneplugin anotherplugin

## Options

`--installed`

  : Show the descriptor of installed CPrAN plugins.

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
