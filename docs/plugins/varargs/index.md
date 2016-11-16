---
layout: page
group: pod
title: varargs
---
{% include JB/setup %}

"varargs" makes it possible to write variadic procedures in Praat, and provides
an alternative method for calling procedures with enhanced support for
recursive calls.

This is done through two main procedures: [`varargs`](#varargs), which uses
procedures that take arguments in the normal way and identifies the appropriate
one to call by using a signature map; and [`@`](#at), which altogether replaces
the standard method of calling procedures, taking full control of the argument
parsing.

## Procedures

### `varargs.proc`

#### @
{: #at }

{% highlight praat linenos %}
include varargs.proc

call @:fibonacci: 7
assert fibonacci.return == 13

procedure fibonacci ()
  if number(.argv$[1]) == 0
    .return = 0
  elsif number(.argv$[1]) == 1
    .return = 1
  else
    call @:fibonacci: number(fibonacci.argv$[1]) - 1
    .a['@.level'] = fibonacci.return

    call @:fibonacci: number(fibonacci.argv$[1]) - 2
    .b['@.level'] = fibonacci.return

    .return = .a['@.level'] + .b['@.level']
  endif
endproc
{% endhighlight %}

This procedure takes a string that looks exactly like one to be used after a
normal procedure call using the standard `@`, which is why it is significantly
easier to call it using `call` (to avoid having to escape all the quotations).

Internally, it parses that string to identify the name of the procedure to call
and the argument list to write into that procedures internal variables, and
calls that procedure.

For this to work, the procedure needs to be declared as having no arguments,
since we are bypassing the Praat parser entirely for this. Instead, the
arguments will be made available using a set of variables:

`.argv$`
  : a space-separated list of parameters (with the last string unquoted)

`.args$`
  : a comma-separated list of parameters

`.argn`
  : the number of passed parameters

`.argt$`
  : the type (string or numeric) of each parameter, as a sequence of single
    characters (`s` and `n` respectively)

`.argv$[]`
  : an indexed variable holding each argument as a string

`.argt$[]`
  : an indexed variable holding the type of each argument as a single character

These variables do not use the `@` namespace, but the namespace of the
procedure that was called using the `@` procedure (eg. in the synopsis, these
would be `fibonacci.argn`, `fibonacci.args$`, etc)

The procedure also internally keeps track of recursive calls, making sure that
subsequent calls do not overwrite the existing arguments, and keeping a counter
of the current execution level. In the synopsis, this is used to store the
"return" value of the lower calls (using the `@.level` variable).

#### varargs: args
{: #varargs }

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

This procedure is to be used as if it were a keyword. Once you've defined
your procedures supporting a variable number of arguments, you call them
as in the example, using `call varargs` and then the rest of a normal
procedure call using colons (without parentheses, and using a comma-separated
list of arguments).

In order to declare procedures supporting this feature, they need
to register all valid signatures, and then implement _every one_ of them.

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

