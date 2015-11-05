---
layout: page
group: client
title: CPrAN
description:
  short: the official CPrAN client, written in Perl
---
{% include JB/setup %}

A plugin manager for Praat
--------------------------

### Current implementation

> The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
> "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be
> interpreted as described in [RFC 2119](http://tools.ietf.org/html/rfc2119).

The current implementation is written in Perl and uses [GitLab][] for its
server-side code. The interface is modeled after `apt` and `dpkg`, but should be
relatively familiar for most people who have used a package manager before.

Inspired by [bower][], the versioning of plugins is left to git, and each
[semantic versioning][semver]-compliant tag represents a new release.
Tags _MUST_ be in the `master` branch to be considered releases.

Each plugin that is in CPrAN _MUST_ have plugin descriptor written in
properly formatted YAML. This descriptor _MUST_ refer to the most recent
release, since this file will be used to keep track of what that most recent
version is. [Here's][descriptor] an example of what CPrAN currently uses.

[descriptor]: https://gitlab.com/cpran/plugin_cpran/blob/master/doc/example.yaml

Ideally, a package manager for Praat should be written in Praat, but that would
be a daunting task indeed. For this very first step of the project, it was
decided to move forward with a prototype that served as a sort of
proof-of-concept. Whether Perl remains the best tool for the job or not, will be
decided later. But details from the interface should be
implementation-independent, which leaves us free to try other alternatives in
the future.

As any good prototype, this is still in its testing stages. You can help by
running it on your own machine and sending in any feedback you might have
regarding both the design of the interface or (if you are technically oriented),
its implementation.

### Installation

Since Praat is cross-platform, it is extremely important for CPrAN to also work
in all the platforms Praat supports, and care has been made to write it so that
that is possible. However, this is a difficult task, so testing on as many
different platforms is recquired.

Now, on to the installation.

1.  **Install Perl**. You will need Perl to run the current version. Skip to
    step 3 if you already have Perl and the modules you'll need, or if you know
    how to set that up.

    If you are on GNU/Linux then chances are you already have it. If not, check
    your distro's documentation on how to get it.

    If you are on Windows, you can find instructions on how to install it
    [here][winperl].

    If you are on Mac, please see [here][macperl].

    > Note: also consider using [perlbrew][] or [plenv][] (or [berrybrew][] if
    > on Windows), which make it easy to set up user-specific perl
    > installations.

    [macperl]: http://learn.perl.org/installing/osx.html
    [winperl]: http://learn.perl.org/installing/windows.html

2. **Install the Perl module**. The Perl client is contained in the
    "[CPrAN][cpran module]" module. At the moment, the module is not available
    through CPAN (the Perl distribution network) but it can be installed using
    [`cpanminus`][cpanminus] with the following command:

        cpanm https://gitlab.com/cpran/CPrAN.git

    You can also install the module manually by downloading the latest
    [archive][module archive], extracting it, and running the following commands
    at its root:

    [module archive]: https://gitlab.com/cpran/CPrAN/repository/archive.zip?ref=master

        perl Makefile.PL
        make
        make test
        make install

    You can make sure that all is well by running `cpran --version` from the
    command line. If that command still fails and you've followed all steps so
    far, go check out the [issues][] page for similar problems, or open a new
    issue to get help.

    You can get some basic usage information by running `cpran help` or
    `cpran help <command>`, where `<command>` is the name of the command
    you want help with.

    [cpran module]: https://gitlab.com/cpran/CPrAN

    > Note: to avoid having to install packages at the system level (ie, with
    > administrator rights), consider using [plenv][] or [perlbrew][] (or
    > [berrybrew][] if you are on Windows). These are perl version managers that
    > allow you to have multiple user-specific Perl installations.
    >
    > If you prefer a _purer_ version, see [the Perl FAQ][faqlibrary] for
    > information on how to install packages as a normal user using regular
    > CPAN, and [the cpanminus wiki][cpanmlibrary] for the same using
    > [`cpanminus`][cpanminus].

    [cpanminus]: https://github.com/miyagawa/cpanminus
    [perlbrew]: https://perlbrew.pl
    [plenv]: http://weblog.bulknews.net/post/58079418600/plenv-alternative-for-perlbrew
    [berrybrew]: http://perltricks.com/article/119/2014/10/10/Hello-berrybrew--the-Strawberry-Perl-version-manager
    [faqlibrary]: http://learn.perl.org/faq/perlfaq8.html#How-do-I-keep-my-own-module-library-directory
    [cpanmlibrary]: https://github.com/miyagawa/cpanminus#where-does-this-install-modules-to-do-i-need-root-access

3.  **Install the CPrAN plugin**. Once the client is installed, you need to
    install the Praat plugin, so that Praat can interact with it. You should be
    able to do this using the CPrAN client itself. First make sure the client is
    available:

        cpran --version

    and then run

        cpran init

    To install the plugin.

4.  **Profit**

    Check the [documentation][cpran docs] for more detailed information about
    all available commands. The [client page](cpran) is probably a good place to
    start.

    [cpran docs]: http://cpran.net/docs

    Make sure to get back with reports of any problems or successes you might
    have on your setup!

### Troubleshooting

#### 500 Status read failed: A non-blocking socket operation could not be completed immediately

See [here](https://gitlab.com/cpran/plugin_cpran/issues/6) for a fix.

#### 403 Forbidden while running update

See [here](https://gitlab.com/cpran/plugin_cpran/issues/25) for details. This has been fixed in [v0.1.7](https://gitlab.com/cpran/plugin_cpran/commits/v0.1.7) and higher. You might have to upgrade manually to the new version if your `update` is broken.

[gitlab]: https://gitlab.com
[bower]: https://github.com/bower/bower
[zip]: https://gitlab.com/cpran/plugin_cpran/repository/archive.zip?ref=master
[semver]: http://semver.org
[preferences directory]: http://www.fon.hum.uva.nl/praat/manual/preferences_directory.html
[issues]: https://gitlab.com/cpran/plugin_cpran/issues
[mainpod]: https://gitlab.com/cpran/plugin_cpran/blob/master/doc/cpran.md
[wiki]: https://gitlab.com/cpran/plugin_cpran/wikis/home
