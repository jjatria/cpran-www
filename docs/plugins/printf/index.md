---
layout: page
group: pod
title: printf
---
{% include JB/setup %}

This plugin provides `printf(3)`-style string formatting procedures
for Praat.

## Overview

These procedures take a _format_ string, and an optional series of
variables, which will get formatted according to the format specification.

Since calls to the provided procedures will take a variable number of arguments,
and Praat does not allow procedures to do this, the procedures provided by this
plugin make use of the `@` procedure from `varargs`. Calling them through any
other mean is not supported, and may result in unexpected behaviour.

The format string will be parsed for the presence of format _prototypes_, and
each of them will be replaced by a formatted version of the appropriate
variable.

## Syntax

Format prototypes are identified by a starting percent character (`%`) followed
by a format specifier, which is a single character. The character specifies the
way in which the variable should be interpreted. Valid specifiers are the
following:

    %%    a percent sign
    %s    a string

    %d    a signed integer, in decimal
    %i    a synonym for %d

    %u    an unsigned integer, in decimal
    %o    an unsigned integer, in octal
    %x    an unsigned integer, in hexadecimal
    %b    an unsigned integer, in binary

    %e    a floating-point number, in scientific notation
    %g    a floating-point number, in %e or %f notation
    %a    a floating-point number, in hexadecimal
    %f    a floating-point number, in fixed decimal notation
    %F    a synonym for %f

    %X    like %x, but using upper-case letters
    %E    like %e, but using an upper-case "E"
    %G    like %g, but with an upper-case "E" (if applicable)
    %B    like %b, but using an upper-case "B" with the # flag
    %A    like %a, but using upper-case letters

Additionally, limited support is given for

    %c    a character with the given number

As an example:

{% highlight praat %}
call @:printf: "<%d>", 12.5     ; prints <12.5>
{% endhighlight %}

Between the `%` character and the specifier, several additional attributes
may be given to control how the specifier is to be interpreted.
In order, these are:

#### Parameter index

Normally, the variables to format are read in order into each of the specifier
characters, but this can be modified by providing an explicit parameter index.

Indices are given by a number followed by a dollar character (`$`), and the
variables are indexed from `1`. As an example:

{% highlight praat %}
call @:printf: "%2$d %1$d",    12, 34      ; prints "34 12"
call @:printf: "%3$d %d %1$d",  1,  2, 3   ; prints "3 1 1"
{% endhighlight %}

#### Flag

After the parameter index, one or more of the following can be provided:

    space   prefix non-negative number with a space
    +       prefix non-negative number with a plus sign
    -       left-justify within the field
    0       use zeros, not spaces, to right-justify
    #       ensure the leading "0" for any octal,
            prefix non-zero hexadecimal with "0x" or "0X",
            prefix non-zero binary with "0b" or "0B"

These result in the following examples:

{% highlight praat %}
call @:printf: "<% d>",  12      ; prints "< 12>"
call @:printf: "<% d>",   0      ; prints "< 0>"
call @:printf: "<% d>", -12      ; prints "<-12>"

call @:printf: "<%+d>",  12      ; prints "<+12>"
call @:printf: "<%+d>",   0      ; prints "<+0>"
call @:printf: "<%+d>", -12      ; prints "<-12>"

call @:printf: "<%6s>",  12      ; prints "<    12>"
call @:printf: "<%-6s>", 12      ; prints "<12    >"

call @:printf: "<%06s>", 12      ; prints "<000012>"

call @:printf: "<%#o>",  12      ; prints "<014>"
call @:printf: "<%#x>",  12      ; prints "<0xc>"
call @:printf: "<%#X>",  12      ; prints "<0XC>"
call @:printf: "<%#b>",  12      ; prints "<0b1100>"
call @:printf: "<%#B>",  12      ; prints "<0B1100>"
{% endhighlight %}

If the `+` and ` ` flags are given, the space is ignored:

{% highlight praat %}
call @:printf: "<%+ d>", 12      ; prints "<+12>"
call @:printf: "<% +d>", 12      ; prints "<+12>"
{% endhighlight %}

#### Width

Arguments are usually formatted to be only as wide as required to display
the given value. This can be overriden by specifying a field width, or by
getting the width from the next argument (with `*` ):

{% highlight praat %}
call @:printf: "<%s>",    "a"         ; prints "<a>"
call @:printf: "<%6s>",   "a"         ; prints "<     a>"
call @:printf: "<%*s>",    6,    "a"  ; prints "<     a>"
call @:printf: "<%2s>",   "long"      ; prints "<long>" (does not truncate)
{% endhighlight %}

If a field width obtained through `*` is negative, it has the same effect
as the `-` flag: left-justification.

#### Precision

The meaning of this attribute depends on the specifier.

A precision (for numeric conversions) or a maximum width (for string
conversions) can be specified with a `.` followed by a number. For
floating-point formats except `%g` and `%G`, this specifies how many
places after the decimal point are shown (the default being 6). For example:

{% highlight praat %}
# these examples are subject to system-specific variation
call @:printf: "<%f>",    1           ; prints "<1.000000>"
call @:printf: "<%.1f>",  1           ; prints "<1.0>"
call @:printf: "<%.0f>",  1           ; prints "<1>"
call @:printf: "<%e>",   10           ; prints "<1.000000e+01>"
call @:printf: "<%.1e>", 10           ; prints "<1.0e+01>"
{% endhighlight %}

For `%g` and `%G`, the precision specifies the maximum number of digits to
show, including those on both sides of the decimal point; for example:

{% highlight praat %}
# These examples are subject to system-specific variation.
call @:printf: "<%g>",     1          ; prints "<1>"
call @:printf: "<%.10g>",  1          ; prints "<1>"
call @:printf: "<%g>",   100          ; prints "<100>"
call @:printf: "<%.1g>", 100          ; prints "<1e+02>"
call @:printf: "<%.2g>", 100.01       ; prints "<1e+02>"
call @:printf: "<%.5g>", 100.01       ; prints "<100.01>"
call @:printf: "<%.4g>", 100.01       ; prints "<100>"
{% endhighlight %}

For integer conversions, specifying a precision implies that the output
of the number itself should be zero-padded to this width, where the `0` flag
is ignored:

{% highlight praat %}
call @:printf: "<%.6d>",    1         ; prints "<000001>"
call @:printf: "<%+.6d>",   1         ; prints "<+000001>"
call @:printf: "<%-10.6d>", 1         ; prints "<000001    >"
call @:printf: "<%10.6d>",  1         ; prints "<    000001>"
call @:printf: "<%010.6d>", 1         ; prints "<    000001>"
call @:printf: "<%+10.6d>", 1         ; prints "<   +000001>"
call @:printf: "<%.6x>",    1         ; prints "<000001>"
call @:printf: "<%#.6x>",   1         ; prints "<0x000001>"
call @:printf: "<%-10.6x>", 1         ; prints "<000001    >"
call @:printf: "<%10.6x>",  1         ; prints "<    000001>"
call @:printf: "<%010.6x>", 1         ; prints "<    000001>"
call @:printf: "<%#10.6x>", 1         ; prints "<  0x000001>"
{% endhighlight %}

For string conversions, specifying a precision truncates the string to fit
the specified width:

{% highlight praat %}
call @:printf: "<%.5s>",   "truncated" ; prints "<trunc>"
call @:printf: "<%10.5s>", "truncated" ; prints "<     trunc>"
{% endhighlight %}

You can also get the precision from the next argument using `.*`:

{% highlight praat %}
call @:printf: "<%.6x>",    1         ; prints "<000001>"
call @:printf: "<%.*x>",    6, 1      ; prints "<000001>"
{% endhighlight %}

If a precision obtained by this method is negative, it is discarded.

{% highlight praat %}
call @:printf: "<%.*s>",  7, "string" ; prints "<string>"
call @:printf: "<%.*s>",  3, "string" ; prints "<str>"
call @:printf: "<%.*s>",  0, "string" ; prints "<>"
call @:printf: "<%.*s>", -1, "string" ; prints "<string>"
call @:printf: "<%.*d>",  1, 0        ; prints "<0>"
call @:printf: "<%.*d>",  0, 0        ; prints "<>"
call @:printf: "<%.*d>", -1, 0        ; prints "<0>"
{% endhighlight %}

If the `#` flag is given or an octal number, the precision may be increased
in order to accommodate the leading `0`:

{% highlight praat %}
call @:printf: "<%#.5o>", 10   ; prints "<00012>"
call @:printf: "<%#.5o>", 5349 ; prints "<012345>"
call @:printf: "<%#.0o>", 0    ; prints "<0>"
{% endhighlight %}

#### Length

[Of limited support in Praat implementation]

## Scripts

For convenience, this plugin includes two scripts that provide access to the
procedures of the same name. They work in exactly the same way as the methods,
described below.

#### printf: format$, args$
{: #printf-script }

A script version of [`@printf`](#printf). The script takes two string arguments:
the first argument is the format string, and the second is a comma-separated
list of arguments to be passed to the internal parser. Because this string
will be parsed, predefined variable names (eg. `undefined`) are acceptable.

#### fprintf: file$, format$, args$
{: #fprintf-script }

A script version of [`@fprintf`](#fprintf). The script takes three string
arguments: the first argument is the name of the file to write to, the
second is the format string, and the last is a comma-separated list of
arguments to be passed to the internal parser. Because this string will
be parsed, predefined variable names (eg. `undefined`) are acceptable.

## Procedures

### `printf.proc`

#### printf()
{: #printf }

{% highlight praat %}
call @:printf: "Running %s in %o\n", "Praat", 1038
assert info$() == "Running Praat in 2016" + newline$
{% endhighlight %}

Format the given variables according to the format string, and print the
results to the info window. This procedure is entirely equivalent to manually
printing the results of a call to [`@sprintf`](#sprintf) with, for example,
`appendInfo()`.

#### sprintf()
{: #sprintf }

{% highlight praat %}
call @:sprintf: "Running %s in %o", "Praat", 1038
assert sprintf.return$ == "Running Praat in 2016"
{% endhighlight %}

Format the given variables according to the format string, and store it in
the `sprintf.return$` variable. Unlike with [`@printf`](#printf), nothing is
printed to the info window after calling this procedure.

Note that this procedure does not automatically append a newline. In order
to do that, it must be a part of the format string.

#### fprintf()
{: #fprintf }

{% highlight praat %}
call @:fprintf: "text.txt", "Running %s in %o\n", "Praat", 1038
file$ = readFile$("text.txt")
assert file$ == "Running Praat in 2016" + newline$
{% endhighlight %}

Format the given variables according to the format string, and append the
results to the file whose name is passed as the first argument. This procedure
is entirely equivalent to manually printing the results of a call to
[`@sprintf`](#sprintf) with, for example, `appendFile()`.

If the file does not exist when the procedure is called, it will be created.

## Implementation

The plugin attempts to outsource the formatting to helper scripts written in
Perl using the `runSystem()` function. In systems where Perl is not available,
a pure-Praat fallback method is provided.

The availbility of Perl is checked automatically when the procedures are
loaded (ie. with `include`), but finer control can be achieved by modifying the
value of the `printf.system` variable at runtime.

Except in those cases where Perl uses a different locale information, the
output of the provided procedures should be the same regardless of what method
is used.

#### A note on performance

Since the Perl helper scripts are executed as system commands, they cannot know
about the info window, and print directly to STDOUT. This would not normally be
a problem when Praat is run from a command line, but even in these cases, the
use of functions like `info$()`, which read the info window (and not STDOUT)
would be different.

In order to maintain a predictable behaviour, the plugin by default captures
the output of the Perl scripts and passes it to the info window. However, this
requires a file I/O operation, which could be a problem. If this is not
desirable, and the effects outlined above are not important, this behaviour
can be altered by setting the `printf.stdout` variable to a true value.

## Acknowledgements

The implementation in Praat follows closely that made by Perl, and this page
itself borrows heavily from the Perl documentation of the [corresponding
function](http://perldoc.perl.org/functions/sprintf.html), including the
examples (except when adjusted to accommotate Praat particulars).
