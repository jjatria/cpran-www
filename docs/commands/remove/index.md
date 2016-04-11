---
layout: page
group: command
title: remove
description:
  short: Remove installed CPrAN plugins
---
{% include JB/setup %}

## Synopsis

    cpran remove [options] [arguments]

## Description

Deletes a cpran plugin that has been installed.

Arguments to **remove** must be at least one and optionally more plugin names to
remove. For each named passed as argument, all contents of the directory named
`plugin_<name>` will be removed from disk.

## Examples

    # Remove some plugins
    cpran remove oneplugin otherplugin
    # Do not ask for confirmation
    cpran remove -y oneplugin

## Options

`--yes` `-y`

  : Assumes yes for all questions.

`--force`

  : Tries to work around problems.

`--debug`

  : Print debug messages.

`--verbose`
`--quiet`
`--cautious`

## See also

* [CPrAN][cprandoc]
* [CPrAN::Plugin][plugin]
* [CPrAN::Command::create][create]
* [CPrAN::Command::deps][deps]
* [CPrAN::Command::init][init]
* [CPrAN::Command::install][install]
* [CPrAN::Command::list][list]
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
