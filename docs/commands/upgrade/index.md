---
layout: page
group: command
title: upgrade
description:
  short: Upgrades installed CPrAN plugins to their latest versions
---
{% include JB/setup %}

## Synopsis

    cpran upgrade [options] [arguments]

## Description

Upgrades the specified CPrAN plugins to their latest known versions.

**upgrade** can take as argument a list of plugin names. If provided, only
those plugins will be upgraded. Otherwise, all installed plugins will be checked
for updates and upgraded. This second case should be the recommended use, but it
is not currently implemented.

## Examples

    # Upgrades all installed plugins
    cpran upgrade
    # Upgrade specific plugins
    cpran upgrade oneplugin otherplugin

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
* [CPrAN::Command::update][update]

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
