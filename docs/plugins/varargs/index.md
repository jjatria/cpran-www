---
layout: page
group: pod
title: varargs
---
{% include JB/setup %}

"varargs" makes it possible to write variadic procedures in Praat.

In order to declare procedures supporting this feature, they need
to register all valid signatures, and then implement _every one_ of them.

See an example below.

{% highlight praat linenos %}
include varargs.proc

# Write the calls with `call` instead of `@`
# but pass arguments separated with commas
# and use the special "keyword" `varargs`
call varargs greet
call varargs greet: "Paul"
call varargs greet: "Goodbye", "David"

# Define your procedures
procedure greet ()
  # Register the valid signatures
  .nil = 1
  .s   = 1
  .ss  = 1

  # Specify any default values
  .ing$  = "Hello"
  .name$ = "World"
endproc

# Implement _all_ signatures
procedure greet.nil ()
  @greet.ss: greet.ing$, greet.name$
endproc

procedure greet.s: .name$
  @greet.ss: greet.ing$, .name$
endproc

procedure greet.ss: .greet$, .name$
  appendInfoLine: .greet$, ", ", .name$, "!"
endproc
{% endhighlight %}

## Procedures

### `varargs.proc`

#### varargs: args
{: #varargs }

{% highlight praat %}
call varargs myproc: 10, "a", "say ""hello!"""
{% endhighlight %}

This procedure is to be used as if it were a keyword. Once you've defined
your procedures supporting a variable number of arguments, you call them
as in the example, using `call varargs` and then the rest of a normal
procedure call using colons (without parentheses, and using a comma-separated
list of arguments).

If the procedure is to take no arguments, simply write

{% highlight praat %}
call varargs myproc
{% endhighlight %}

#### arg: args
{: #arg }

{% highlight praat %}
@arg: argument_list$
{% endhighlight %}

Mostly for internal use, `@arg` will take a string representing a comma-separated
list of arguments, and parse it following the same ruls as implemented in the
rest of Praat. It can be made up of a combination of numeric and string variables,
and string variables must be quoted.

Inputting this string as a string constant will in general be very awkward, so
it is best to construct it in contexts in which unquoted strings are accepted
(eg. in a shorthand procedure call).

The procedure will parse the list and store some information on it in the
following variables:

`.v$`
  : A space-separated representation of the argument list, ready to be used in
    a shorthand procedure call (using the `call` directive). In this string,
    strings will be quoted unless they are the final argument, and in that case
    they will be bare. An empty argument list generates the empty string.

`.v$[]`
  : An indexed variable with each parsed argument as a separate string.

`.n`
  : The number of parsed arguments. `0` if the argument list was empty.

`.t$`
  : The signature of the argument list, as a string of `n` and `s` characters
    representing strings and numerics respectively. An empty argument list will
    generate the explicitly empty `nil` signature.

The reason this procedure is _mostly_ for internal use, is that it can be
conveniently used to create procedures that take an indeterminate number of
arguments. If in the previous examples a number of different combinations were 
possible, the set of possible combinations was strictly defined. This is not
necessary.

The following example implements a `@mean` procedure that calculates the 
mean of however many numeric arguments are passed, similar to how the `min()`
standard Praat function operates:

{% highlight praat linenos %}
include varargs.proc

call mean: 1, 23, 5, 23, 6, 7
appendInfoLine: mean.return

procedure mean: .args$
  @arg: .args$
  .x = 0
  for .i to arg.n
    .x += number(arg.v$[.i])
  endfor
  .return = .x / arg.n
endproc
{% endhighlight %}

Be advised, however, that every call to `@arg` will overwrite the previous
list of parsed arguments. If there is any chance `@arg` will be called while 
you still need to process a previous list of arguments, make sure to make a
local copy first.

