---
layout: page
group: command
title: list
description:
  short: List all known CPrAN plugins
---
{% include JB/setup %}

## Synopsis

cpran list \[options\]

## Description

List plugins available through the CPrAN catalog.

**list** will show a list of all plugins available to CPrAN.

## Examples

    # Show all available plugins
    cpran list

## See also

* [CPrAN][cprandoc]
* [CPrAN::Plugin][plugin]
* [CPrAN::Command::create][create]
* [CPrAN::Command::deps][deps]
* [CPrAN::Command::init][init]
* [CPrAN::Command::install][install]
* [CPrAN::Command::remove][remove]
* [CPrAN::Command::search][search]
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
