---
layout: page
group: command
title: deps
description:
  short: List the dependencies of CPrAN plugin
---
{% include JB/setup %}

## Synopsis

    cpran deps [options] [arguments]

## Description

This command checks the dependencies of the specified plugins and returns them
in an ordered list, such as can be used in an installation schedule. While
the internally returned list contains all plugins in the dependency tree,
all but the topmost element are printed to STDOUT, so that the aggregated
list of _dependencies_ is what is printed.

The results of this command can be piped into e.g. [`cpran install`][install]
to prepare things for the installation of the plugins passed as arguments.

Arguments to B<deps> must be at least one and optionally more plugin names.
Plugin names can be appended with a specific version number to request for
versioned queries, but this is not currently implemented. When it is, name
will likely be of the form `name-1.0.0`.

## Example

    # List the dependencies of a plugin
    cpran deps basicplugin
    # List the aggregated dependencies of multiple plugin
    cpran deps basicplugin complexplugin
    # Reinstall all dependencies for a plugin
    cpran deps plugin | cpran install --reinstall

## Method

<span>`get_dependencies`</span>{:#get-dependencies}

  : Query the desired plugins for dependencies.

    Takes either the name of a single plugin, or a list of names, and return
    an array of hashes properly formatted for processing with
    [order_dependencies](#order-dependencies).

<span>`order_dependencies`</span>{:#order-dependencies}

  : Order required packages, so that those that are depended upon come up first
    than those that depend on them.

    The argument is an array of hashes, each of which needs a "name" key that
    identifies the item, and a "reqname" holding the reference to an array with
    the names of the items that are required.

    Code for this method has been based on [an answer][answer] by [ikegami][]
    on StackOverflow.

    [ikegami]: https://stackoverflow.com/users/589924/ikegami
    [answer]:  https://stackoverflow.com/a/12166653/807650

## See also

* [CPrAN][cprandoc]
* [CPrAN::Plugin][plugin]
* [CPrAN::Command::init][init]
* [CPrAN::Command::install][install]
* [CPrAN::Command::list][list]
* [CPrAN::Command::remove][remove]
* [CPrAN::Command::search][search]
* [CPrAN::Command::show][show]
* [CPrAN::Command::test][test]
* [CPrAN::Command::update][update]
* [CPrAN::Command::upgrade][upgrade]

[cprandoc]: {{ BASE_PATH }}/docs/cpran
[plugin]:   {{ BASE_PATH }}/docs/plugin
[init]:     {{ BASE_PATH }}/docs/commands/init
[install]:  {{ BASE_PATH }}/docs/commands/install
[list]:     {{ BASE_PATH }}/docs/commands/list
[remove]:   {{ BASE_PATH }}/docs/commands/remove
[search]:   {{ BASE_PATH }}/docs/commands/search
[show]:     {{ BASE_PATH }}/docs/commands/show
[test]:     {{ BASE_PATH }}/docs/commands/test
[update]:   {{ BASE_PATH }}/docs/commands/update
[upgrade]:  {{ BASE_PATH }}/docs/commands/upgrade
