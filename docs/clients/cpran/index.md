---
layout: page
group: pod
title: CPrAN
description:
  short: The official CPrAN client, written in Perl
---
{% include JB/setup %}

## Synopsis

    cpran <command> [global options] [options] [arguments]

## Description

**cpran** is the main script for an
[App::Cmd](https://metacpan.org/pod/App::Cmd) application to search, install,
remove and update Praat plugins.

### Commands

- **update**

        cpran update [options]
        cpran update [options] [names]

    CPrAN keeps a list of the available plugins, with information about each
    one, including what its latest verion is and who is in charge of maintaining
    it.

    As its name implies, the **update** command takes care of keeping this list
    up to date, so it should probably be the first command to run. It might be
    useful to run it with the **\-\-verbose** option enabled, to keep track on
    what it is doing.

    The list is currently implemented as individual files in the .cpran
    directory, which is under the CPrAN root. See [**update**][update] for the
    full documentation.

- **search**

        cpran search [options] [regex]

    **search** makes it possible to look for plugins in the plugin list. If you
    are not sure about the name of a plugin, you can use **search** to explore
    the list and try to find it. Or you can just use it to browse, to find
    unknown plugins that might do what you need.

    **search** will return a list of all plugin names that match the provided
    regular expression. Currently, it only attempts to match it in the plugin's
    name, but future versions will allow matches against other fields as well.

    By using the **\-\-installed** option you can perform this search on your
    installed plugins, which will additionally show you the local and remote
    versions, so you can visually check if plugins any need upgrading.

    **search .\*** will show the entire list of plugins (beware that this might
    be a long list!). Alternatively, you can use the **list** command, which is
    simply an alias for this query.

    See [**search**][search] for the full documentation.

- **show**

        cpran show [options] [names]

    Each plugin has a descriptor with general information about the plugin,
    including its name, version, homepage, maintainer, description, etc.
    **show** allows you to read the contents of this file.

    By default, it will show you the descriptors downloaded by **update**, but
    you can also use the **\-\-installed** option to read the descriptors of
    installed plugins.

    See [**show**][show] for the full documentation.

- **install**

        cpran install [options] [names]

    Once you've found a plugin with **search** and figured out if you want to
    install it or not thanks to **show**, you can use **install** to download a
    copy of the latest version to your local Praat preferences directory. If the
    plugin's descriptor specifies any dependencies, **install** will also offer
    to install these.

    You also use **install** to re-install a plugin that has already been
    installed with the **\-\-force** option. This is useful if your local
    version somehow becomes corrupted (eg, if you've accidentally deleted files
    from within it).

    See [**install**][install] for the full documentation.

- **upgrade**

        cpran upgrade
        cpran upgrade [options] [names]

    If a new version of an installed plugin has been released, you can use
    **upgrade** to bring your local installation up to date. You can specify a
    name to upgrade that individual plugin, or you can call it with no
    arguments, to upgrade all plugins that are out of date.

    See [**upgrade**][upgrade] for the full documentation.

- **remove**

        cpran remove [options] [names]

    If you are not going to be using a plugin anymore, you can remove it with
    **remove**.

    See [**remove**][remove] for the full documentation.

- **test**

        cpran test [options] [names]

    By default, part of the installation process involves testing the downloaded
    plugin to make sure that things are working as expected.

    Both the testing and the aggregation of the test results is done by
    **test**.

    The command can be run manually on any downloaded plugin. When given the
    name of a plugin, regardless of whether it is a CPrAN plugin or not, it will
    look in that plugin's directory for a test directory.

    By default and convention, the test directory is named `t` and resides at
    the root of the plugin. Within this directory, all files that have a `.t`
    extension will be regarded as tests. Tests are all run by Praat, and they
    are expected to conform to the [Test Anything Protocol][tap] for correct
    evaluation. You might want to look at the [testsimple][] plugin to make it
    easier to write tests.

    See [**test**][test] for the full documentation.

### Options

- **\-\-praat**=PATH

    The path to use as the preferences directory for Praat. See the
    [_Files_](#files) section for information on the platform-dependant default
    values used.

- **\-\-cpran**=PATH

    The path to use as the CPrAN root directory. See the [_Files_](#files)
    section for information on the platform-dependant default values used.

- **\-\-api-token**=TOKEN
- **\-\-api-group**=GROUP\_ID
- **\-\-api-url**=URL

    These options set the credentials to talk to the GitLab API to obtain the
    plugin archives and descriptors. As such, it is implementation-dependant,
    and is currently tied to GitLab. These options are particularly useful if
    using CPrAN as an in-house plugin distribution system.

- **\-\-verbose**, **\-\-v**

    Increase the verbosity of the output. This option can be called multiple
    times to make the program even more talkative.

- **\-\-quiet**, **\-\-q**

    Opposed to **\-\-verbose**, this option _suppresses_ all output. If both
    options are set simultaneously, this one takes precedence.

- **\-\-debug**, **\-\-D**

    Enables the output of debug information. Like **\-\-verbose**, this option
    can be used multiple times to increase the number of debug messages that are
    printed.

## Examples

    # Update the list of known plugins
    cpran update
    # Shows the entire list of known plugins
    cpran search .*
    # Search in the known plugin list for something
    cpran search something
    # Search in the installed plugin list for something
    cpran search -i something
    # Show the descriptor of a plugin by name
    cpran show name
    # Install a plugin by name
    cpran install name
    # Upgrade all plugins to their most recent version
    cpran upgrade
    # Upgrade a plugin by name to its most recent version
    cpran upgrade name
    # Remove a plugin by name from disk
    cpran remove name

## Files

### The preferences directory

**CPrAN** needs read and write access to _Praat_'s preferences directory. The
exact location for this directory varies according to the platform, so **CPrAN**
will keep the path to it, accessible through CPrAN::praat().

Below are the default locations for the main supported platforms:

- _UNIX_

    `~/.praat-dir`

- _Macintosh_

    `/Users/username/Library/Preferences/Praat/Prefs`

- _Windows_

    `C:\Documents and Settings\username\Praat`

Where `username` is, of course, the name of the active user.

Functions like installed() and is\_plugin() look in this directory to get their
information.

### Plugin descriptors

**CPrAN** plugins are identified as such by the presence of a _plugin
descriptor_ in the plugin's root. The descriptor (named `cpran.yaml`) is a YAML
file with fields that identify the name and version of the plugin, what it does,
what its requirements are, etc.

A commented example is bundled with this module as `example.yaml`, but here is
a version stripped of comments, for simplicity:

    ---
    Plugin: name
    Homepage: https://example.com
    Version: 1.2.3
    Maintainer: A. N. Author <author@example.com>
    Depends:
      praat: 5.0.0+
    Recommends:
    License:
      - GPL3 <https://www.gnu.org/licenses/gpl-3.0.html>
      - MIT <http://opensource.org/licenses/MIT>
    Readme: readme.md
    Description:
      Short: an example of a plugin descriptor
      Long: >
        This file serves as an example of a CPrAN plugin descriptor.

        This long description is optional, but very useful to have.
        Line breaks in the long description will be converted to
        spaces, but you can start a new paragraph by using a blank
        line.

        Like so.

**CPrAN** uses YAML::XS to attempt to parse the descriptor. Any error in parsing
will be treated by **CPrAN** in the same way as if the file was missing, so it's
important to properly validate the descriptor beforehand.

### The plugin list

To keep track of available plugins, **CPrAN** keeps the descriptors for all the
plugins it knows about, and queries them for information when necessary. This is
the list that known() looks in, and the list from where the **show** command
gets its data.

The descriptors are saved in a **CPrAN** root folder whose path is stored
internally and accessible through CPrAN::root(). By default, it will be a
directory named `.cpran` in the Praat preferences directory. In that directory,
the descriptors are renamed with the name of the plugin they represent.

This list is updated with the **update** command.

[testsimple]: http://cpran.net/plugins/testsimple
[tap]:        http://testanything.org/
[update]:     http://cpran.net/docs/commands/update
[search]:     http://cpran.net/docs/commands/search
[show]:       http://cpran.net/docs/commands/show
[install]:    http://cpran.net/docs/commands/install
[upgrade]:    http://cpran.net/docs/commands/upgrade
[remove]:     http://cpran.net/docs/commands/remove
[test]:       http://cpran.net/docs/commands/test
