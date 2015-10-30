---
layout: page
group: pod
title: Clients
description:
  short: What is a CPrAN client? How do I make one?
---
{% include JB/setup %}

## Description

CPrAN as a protocol defines a method for the distribution, managing, and testing
of Praat plugins, but this is independent of the specific implementation of that
protocol.

The implementation is left to clients: programs that make use of that interface
to communicate with a CPrAN-compatible server and make the necessary queries to
get lists of plugins, check their dependencies, download the appropriate
versions, etc.

There is currently only one experimental client written in Perl. While the
client is still under development and more testing is welcome, the entire
interface is implemented and the client is considered stable enough for using.
Until [a full spec][spec] is written, the implementation of the interface in
[the Perl client][perl] can serve to disambiguate details of the protocol.

[perl]: {{BASE_PATH}}/docs/cpran
[spec]: {{BASE_PATH}}/docs/clients/cpran

## License

Copyright 2015 José Joaquín Atria

This module is free software; you may redistribute it and/or modify it under
the same terms as Perl itself.

## See also

* [CPrAN]({{ BASE_PATH }}/docs/cpran)
* [CPrAN Plugins]({{ BASE_PATH }}/docs/plugins)
* [CPrAN Commands]({{ BASE_PATH }}/docs/commands)
