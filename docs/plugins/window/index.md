---
layout: page
group: pod
title: window
---
{% include JB/setup %}

The `window` plugin makes it easier to implement windowing algorithms by taking
care of the generation and handling of windows and providing extensible features
to customise what happens within those windows.

Like the [`vieweach`][] plugin, this is done by means of
[procedure predefinition][]. Please refer to that plugin's documentation for a
more detailed explanation of the principles behind this approach.

[vieweach]: {{ BASE_PATH }}/plugins/vieweach
[procedure predefinition]: {{ BASE_PATH }}/docs/plugins/vieweach/procedure-predefinition

See [below](#hooks) for a list of the individual predefinable procedures and
what they mean.

> Note: as far as Praat is concerned, **there is no difference between what are
here called "procedures" and "hooks"**. The only difference is that the latter
are designed to be overwritten, while the former are designed to be used as they
are, but the user is free to ignore this (at their own risk).

## Variables

`window.elasticity` :
  How flexible the window durations should be. Because of rounding errors,
  setting this to 0 (= no elasticity at all) might result in the production of
  windows of extremely marginal durations. A small elasticity value can prevent
  this. This variable defaults to 0.000001, meaning that a window with a desired
  duration of 1 second, might in some cases have a duration of up to 1.000001
  seconds.

`window.index` :
  The index of the current window. Manually modifying this value might have
  unexpected consequences.

`window.start` :
  The start time of the current window.

`window.end` :
  The end time of the current window.

## Procedures

#### window: type$, value, overlap

The main iterating procedure, when called sets the iterations in motion. By the
time it is called, The selection must hold an object with a time axis, meaning
one for which operations like `Get total duration` are available. The windows
will be generated using the duration of this object.

In order to calculate the position of the windows, the procedure requires either
a total number of desired windows, or a desired window duration.

This value is passed to the windowing procedure as the `value` argument, which
will be interpreted depending on the value of the `type$` argument. When `type$`
is `"duration"`, then the value will be taken to be the desired window duration
in seconds. Alternatively, if set to `"number"`, the value will specify the
total number of windows to fit in the time interval.

The time shift between windows is specified with the last argument, `overlap`.
This number is interpreted as a proportion of overlap for consecutive windows,
such that an overlap of 0 means the windows do not overlap at all, and an
overlap of 0.5 means that they overlap by half of the duration of the window.

Note that the amount of overlap is taken into consideration when calculating
the number of windows. This means that specifying a set number of 10 windows
in a 1-second long Sound object would result in 10 0.1-second windows if the
overlap was set to 0, but in 10 0.18-second windows if the overlap is 0.5.

An `overlap` value of 1 would mean that the windows overlap entirely, and is
therefore not allowed with the current API.

In most cases, the value of the `overlap` argument will be in the range
`0 <= x < 1`. But this is not necessary. By extension of the above, a negative
`overlap` value would mean that there is a gap between the windows.

##### Iterating backwards

Specifying an `overlap` value greater than `1` results in a special case. Since
the windows overlap by _more_ than the duration of the window itself, this means
that the "next" window should start before the beginning of the current one.

In this case, the iteration is done from the end of the object, such that the
`overlap` value can be honoured in a way that makes sense.

## Hooks

#### window.action

Executed once for each window. When this procedure is called, the selection is
guarranteed to be the same as the object that was selected when `@window` was
called.

#### window.before_iteration

Executed before the iteration begins.

#### window.after_iteration

Executed after the iteration ends.
