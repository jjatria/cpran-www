---
layout: page
group: command
title: remove
description:
  short: Remove installed CPrAN plugins
---
{% include JB/setup %}

## Synopsis

cpran remove \[options\] \[arguments\]

## Description

Deletes a cpran plugin that has been installed.

Arguments to **remove** must be at least one and optionally more plugin names to
remove. For each named passed as argument, all contents of the directory named
"plugin\_<name>" will be removed from disk.

## Examples

    # Remove some plugins
    cpran remove oneplugin otherplugin
    # Do not ask for confirmation
    cpran remove -y oneplugin

## Options

- **--yes, -y**

    Assumes yes for all questions.

- **--force**

    Tries to work around problems.

- **--debug**

    Print debug messages.

- **--verbose**
- **--quiet**
- **--cautious**

## See also

* [CPrAN]({{ BASE_PATH }}/docs/cpran)
* [CPrAN::Plugin]({{ BASE_PATH }}/docs/plugins)
* [CPrAN::Command::install]({{ BASE_PATH }}/docs/commands/install)
* [CPrAN::Command::search]({{ BASE_PATH }}/docs/commands/search)
* [CPrAN::Command::show]({{ BASE_PATH }}/docs/commands/show)
* [CPrAN::Command::test]({{ BASE_PATH }}/docs/commands/test)
* [CPrAN::Command::update]({{ BASE_PATH }}/docs/commands/update)
* [CPrAN::Command::upgrade]({{ BASE_PATH }}/docs/commands/upgrade)
