---
layout: post
title: "Rationale"
description: ""
category:
tags: []
---
{% include JB/setup %}

![CPrAN]({{ BASE_PATH }}/assets/images/text_logo-small.png)

A plugin manager for Praat
--------------------------

> TL;DR: Check out the current implementation [here][perl client] and read about
> how to install it [here][installation]. Read about how to use it
> [here][usage].

[perl client]:  /clients/cpran
[installation]: /clients/cpran#installation
[usage]:        /docs/cpran

### The problem

Praat has a rich user base, and a versatile scripting language, which would lead
one to expect it to also have a significant number of user-created scripts to
extend the behaviour of Praat for specific tasks.

This is true to a certain extent. But whatever exchange and code sharing that
does take place, does so in a very de-centralised way. There are [some][1]
[sites][2] [out][3] [there][4] that try to solve this by offering lists of
scripts that can be used either independently or in unison. But since they are
all the result of individual efforts, they tend to be largely unmaintained and
easily forgotten. Indeed, while getting the links to the sentence above I came
across [a][5] [large][6] [number][7] of broken links to other similar sites.

A side effect of this is, of course, that it is very hard to keep tabs on what
_is_ out there, and of when any of those are updated or abandoned.

Pair this with the lack of generally accepted coding guidelines, many different
ideas about how scripts should behave and what they should do, and a worrying
number of idiosyncratic coding practices, and you inevitably arrive at the
point where the scripts that _are_ out there offer no guarantee of
interoperability, and no clear channels through which to report problems. This
is where we are today.

Researchers will often find a script that is designed to do a _very specific_
task, and will then modify it to do _another_ very specific task, sometimes
taking the bits of relevant code from _another_ script that was also written
with a very specific task in mind. Most of the time, this will be done without
really understanding what the source scripts did in the first place.

The result is more often than not, a script that is messy, buggy, inefficient,
hard to understand and impossible to maintain. And when a good enough number of
such scripts is collected, they will be put up in a website somewhere. Rinse and
repeat.

Now, this does not mean that there are no [good][8] and [interesting][9]
[projects][10] out there, or good, well though-out [sets of scripts][11] or
tools to use as elements in your own work. It also does not mean that there are
no people writing quality code in Praat. But it _does_ mean that for every good
script out there, there are a lot more that aren't.

The whole point of having a scripting language in the first place is to
facilitate reproducibility, which is a key aspect of the scientific endeavour.
But the practices that we've developed as a community of Praat users lead
exactly in the opposite direction.

In fact, I have got to a point where I often don't even _bother to look_.

_This is not code re-use_. _This is not code sharing_. What we have is a culture
in which these practices are generally difficult. What we need is to generate a
space that makes these practices inevitable.

 [1]: http://www.ling.gu.se/~jonas/sounds/
 [2]: http://www.helsinki.fi/~lennes/praat-scripts/
 [3]: http://www.linguistics.ucla.edu/faciliti/facilities/acoustic/praat.html
 [4]: http://stel.ub.edu/labfon/en/praat-scripts

 [5]: http://fips.igl.uni-freiburg.de/~peter/praat2html.htm
 [6]: http://www.ling.lu.se/persons/JohanF/PRAATSCRIPTS/
 [7]: http://www.biols.susx.ac.uk/home/Chris_Darwin/

 [8]: http://www.praatvocaltoolkit.com/
 [9]: https://sites.google.com/site/speechrate/
[10]: http://www.phon.ucl.ac.uk/home/yi/ProsodyPro/
[11]: https://github.com/drammock/praat-semiauto

### A solution

One possible solution for this is to have _a single centralised_ space where
scripts and tools are placed for everyone to see. That makes it easy to search
for updates and documentation. That makes it easy to report specific bugs and
get help, and to submit bug fixes if they are necessary.

None of this is revolutionary. Indeed, most of us use spaces like this everyday:
if you use R, you've probably used [CRAN][]. If you use (La)TeX, you've probably
used [CTAN][]. If you use Perl, you've probably used [CPAN][] (and you're probably
starting to see a naming pattern here). Most GNU/Linux distributions use similar
systems themselves. [Homebrew][] attempts to offer the same platform for MacOS. Etc.

[cran]: http://cran.r-project.org/
[ctan]: http://www.ctan.org/
[cpan]: http://www.cpan.org/
[homebrew]: http://brew.sh/

A package manager, in the tradition of those mentioned above, is what I think
the Praat community lacks. And that is what this project will attempt to offer.

CPrAN will be the Comprehensive Praat Archive Network.

And in fact, most of the work is already done for us. Praat already _has_
features that facilitate code sharing and reuse: [plugins][]. All we need is to
make it easier to share plugins, and to make it easier for plugins to use each
other.

Let's make one thing clear: even if such a system were to be established, it
would not be the automatic solution to the problems highlighted above. The
solution to those problems needs a community, not a platform. But the platform
can help us build a community. That's what we're after.

### The design

The way I imagine this to work would be with a central repository for Praat
that concentrated code submissions. They could then be held up to some standard
in terms of a guarantee of interoperability, level of documentation, etc.

The repository would have an API that would allow any compliant client to
search, browse and download the hosted plugins, as well as keep them up to date
and remove them if desired.

The client would make sure to install any requirements that exist, and hopefully
to test each plugin as it is installed, to ensure that no broken plugins are
installed (like most package managers out there currently do).

[plugins]: http://uvafon.hum.uva.nl/praat/manual/plug-ins.html

And the best thing about all this is **[we already have a working
prototype][perl client]**. Go read that page to see what the current implementation
looks like and how you can try it out yourself _today_.
