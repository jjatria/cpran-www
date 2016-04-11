---
layout: page
group: command
title: create
description:
  short: Create a new plugin from a template
---
{% include JB/setup %}

## Synopsis

    cpran create [options] [name]

## Description

To make it easier for plugin authors, this command will generate a new blank
plugin in the current directory. The creation follows the template found
in the [**template**][template] plugin, which reproduces the directory strcture
common to most other plugins.

[template]: http://cpran.net/plugins/template

When given an argument, that argument will be used as the name for the new
plugin, as long as no other plugins with name exist. If no arguments are
provided, a random name will be generated.

## Examples

    # Create a new plugin with a random name
    cpran create
    # Create a new plugin with a given name
    cpran create my-awesome-plugin

## Options

`--author` `-A`

  : Provide the author name (not currently implemented)

## See also

* [CPrAN][cprandoc]
* [CPrAN::Plugin][plugin]
* [CPrAN::Command::deps][deps]
* [CPrAN::Command::init][init]
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
