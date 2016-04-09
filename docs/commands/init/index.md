---
layout: page
group: command
title: init
description:
  short: Initialise a CPrAN installation
---
{% include JB/setup %}

## Synopsi

    cpran init [options] [arguments]

## Description

The [cpran plugin][] serves as a bridge between the actions of the
[CPrAN client][cprandoc] and Praat. Te plugin on its own does very little, but
it can be used by other plpugins to e.g. populate a single menu with their
exposed commands, instead of cluttering the Praat menu.

In the future, modifying its list of dependencies (currently empty) will
also make it possible to flag certain plugins as "core", and make them available
in all CPrAN installations.

This command installs the [cpran plugin][] on an otherwise empty system.

## Example

    # Initialise CPrAN
    cpran init

## See also

* [CPrAN][cprandoc]
* [CPrAN::Plugin][plugin]
* [CPrAN::Command::deps][deps]
* [CPrAN::Command::install][install]
* [CPrAN::Command::list][list]
* [CPrAN::Command::remove][remove]
* [CPrAN::Command::search][search]
* [CPrAN::Command::show][show]
* [CPrAN::Command::test][test]
* [CPrAN::Command::update][update]
* [CPrAN::Command::upgrade][upgrade]

[cpran plugin]: {{ BASE_PATH }}/docs/plugins/cpran
[cprandoc]: {{ BASE_PATH }}/docs/cpran
[plugin]:   {{ BASE_PATH }}/docs/plugin
[init]:     {{ BASE_PATH }}/docs/commands/init
[deps]:     {{ BASE_PATH }}/docs/commands/dep
[install]:  {{ BASE_PATH }}/docs/commands/install
[list]:     {{ BASE_PATH }}/docs/commands/list
[remove]:   {{ BASE_PATH }}/docs/commands/remove
[search]:   {{ BASE_PATH }}/docs/commands/search
[show]:     {{ BASE_PATH }}/docs/commands/show
[test]:     {{ BASE_PATH }}/docs/commands/test
[update]:   {{ BASE_PATH }}/docs/commands/update
[upgrade]:  {{ BASE_PATH }}/docs/commands/upgrade

