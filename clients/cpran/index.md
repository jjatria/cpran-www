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

The current implementation is written in Perl and uses [GitLab][] for its
server-side code. The interface is modeled after `apt` and `dpkg`, but should be
relatively familiar for most people who have used a package manager before.

Ideally, a package manager for Praat should be written in Praat, but that would
be a daunting task indeed, and likely impossible. Whether Perl remains the best
tool for the job or not, will be decided later. But details from the interface
should be implementation-independent, which leaves us free to try other
alternatives in the future.

This client is still in its testing stages, but it is stable enough to use. You
can help by running it on your own machine and sending in any feedback you might
have regarding both the design of the interface or (if you are technically
oriented), its implementation.

### Installation

1.  **Install Perl**. You will need Perl to run the current version. Skip to
    the next step if you already have Perl or if you know how to set that up. If
    you are not sure if you have Perl installed, try running

        perl -v

    There are some good guides at the [Perl website](http://perl.org) to install
    it on [Windows][winperl], [Mac][macperl], and [GNU/Linux][linuxperl].

    [macperl]: http://learn.perl.org/installing/osx.html
    [winperl]: http://learn.perl.org/installing/windows.html
    [linuxperl]: http://learn.perl.org/installing/unix_linux.html

2. **Install the Perl module**. The Perl client is contained in the
    "[CPrAN][cpran module]" module. At the moment, the module is not available
    through CPAN (the Perl distribution network) but it can be installed using
    [`cpanminus`][cpanminus] with the following command:

        cpanm https://gitlab.com/cpran/CPrAN.git
        # Or alternatively
        cpanm https://gitlab.com/cpran/CPrAN/repository/archive.tar.gz?ref=master

    (If this doesn't work, try first updating cpanminus iself with
    `cpanm App::cpanminus`).

    If not using `cpanminus`, you can download the [module archive][archive]
    manually, extract it, and run the following commands at its root:

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

    [cpanminus]: https://github.com/miyagawa/cpanminus
    [perlbrew]: https://perlbrew.pl
    [plenv]: http://weblog.bulknews.net/post/58079418600/plenv-alternative-for-perlbrew
    [berrybrew]: http://perltricks.com/article/119/2014/10/10/Hello-berrybrew--the-Strawberry-Perl-version-manager

3.  **Install the CPrAN plugin**. Once the client is installed, you need to
    install the Praat plugin so that Praat can interact with it. You should be
    able to do this using the CPrAN client itself by running

        cpran init

    to install the plugin. That's it!

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

See [here](https://gitlab.com/cpran/plugin_cpran/issues/25) for details. This
has been fixed in [0.0107](https://gitlab.com/cpran/plugin_cpran/commits/v0.1.7)
and higher (note: what was then called v0.1.7). You might have to upgrade
manually to the new version if your `update` is broken.

[gitlab]: https://gitlab.com
[bower]: https://github.com/bower/bower
[archive]: https://gitlab.com/cpran/plugin_cpran/repository/archive.zip?ref=master
[semver]: http://semver.org
[issues]: https://gitlab.com/cpran/plugin_cpran/issues
