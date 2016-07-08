---
layout: page
group: pod
title: utils
---
{% include JB/setup %}

"utils" provides a set of basic utilities that are useful primarily for
scripting, but some of the commands provided as scripts will also be useful for
regular users.

## Scripts

#### Save selected objects: path, overwrite
{: #save-all }

When saving multiple objects to disk, Praat offers to save them as a
_Collection_ object: an object that represents the group of objects that are
currently selected. This can be useful to write groups of files to disk, but
more users will often want to save each selected object individually to disk.

The `Save selected objects...` command does just this: it will loop through each
object and save it to disk as either a text file or, in the case of Sound
objects, as a WAV file. _LongSound_ objects are ignored, since these by
definition will have a direct representation already existing on disk.

Multiple Praat objects can have the same name, but this is not the case for
files in the file system. This command takes care of this by identifying
conflicting names and automatically generating new ones. If the automatic
generation of unique names is not successful, the user is prompted for input
(or files are overwritten if running in a non-interactive session).

#### Rename (regex): pattern, replace
{: #rename-regex }

The `Rename...` command in the standard Praat toolkit only works with a single
selected object and a fully specified name. This command makes it possible to
rename multiple objects in the Object list by specifying the new names as a
regular expression pattern. The command uses Praat's
[regular expressions][regex].

[regex]: http://www.fon.hum.uva.nl/praat/manual/Regular_expressions.html

## Procedures

### `utils.proc`

#### pwgen: length
{: #pwgen }

    @pwgen: 10
    assert length(pwgen.return$) == 10
    # pwgen.return$ is a random alphanumeric string

This procedure aims to provide similar functionality to the [`pwgen(1)`][pwgen]
UNIX command, which generates "pronounceable" random strings. The current
version, however, simply acts as a simplified version of [@rndstr](#rndstr). In
the future this will hopefully change.

[pwgen]: http://linux.die.net/man/1/pwgen

The value in `length` specifies the number of characters in the resulting
string, which is stored in `.return$`.

#### rndstr: length, charset$
{: #rndstr }

    @rndstr: 10, "a1"
    assert length(rndstr.return$) == 10
    # Same as the @pwgen call above

Generate a random string with `length` characters. The string in `charset$`
specifies which sets of characters should be used to generate this string. Each
character set has an identifying character, and will become available if that
character is contained within `charset$`. There are four different sets:

Lowercase alphabetic (`a`)
  : `abcdefghijklmnopqrstuvwxyz`

Uppercase alphabetic (`A`)
  : `ABCDEFGHIJKLMNOPQRSTUVWXYZ`

Numeric (`1`)
  : `0123456789`

Symbols (`%`)
  : `!?@#$%&+_`

#### split: separator$, string$
{: #split }

    @split: " ", "correct horse battery staple"
    assert split.length == 4
    for i to split.length
      appendInfoLine: split.return$[i]
    endfor
    # Prints
    #   correct
    #   horse
    #   battery
    #   staple

Takes the contents of `string$` and separates it into a number of smaller
strings using the string in `separator$` as the separator string. The separator
can be longer than one character. The match is made using it as a string
literal.

The split substrings are stored in the `.return$[]` indexed variable, which will
have a length equal to the value in `.length`.

#### mktemp: template$
{: #mktemp }

    @mktemp: "somefolder_XXXXXX"
    assert fileReadable: mktemp.return$

Similar to the UNIX [`mktemp(1)`][mktemp] command, this procedure creates a
directory with a name that is guaranteed to not exist at the time the procedure
was called. This procedure is not thread-safe, but is useful for storing
temporary files. The directory will _not_ be automatically deleted.

[mktemp]: http://linux.die.net/man/1/mktemp

The name of the directory is generated based on the contents of `template$`,
which needs to be of the form `baseXXXXX`, in which each `X` character will be
replaced with a random one using a single character from the `"a1"` character
set as defined in [@rndstr](#rndstr). The template must have _at least_ three
random placeholders at the end.

If no valid template is provided, no action will be taken and the returned
string will be `--undefined--`. If the template is the empty string,
`"tmp.XXXXXXXXXX"` will be used as a default.

The name of the directory is stored in `.return$`, and the directory is created
automatically.

#### mktempfile: template$
{: #mktempfile }

    @mktempfile: "somefile_XXXXXX"
    assert fileReadable: mktemp.return$

Similar to [@mktemp](#mktemp), bu this procedure creates temporary files. The
interface for both procedures is exactly the same.

#### zeropad: number, length
{: #zeropad }

    @split: ",", "1,45,1350"
    for i to split.length
      @zeropad: number(split.return$[i]), 4
      appendInfoLine: zeropad.return$
    endfor
    # Prints
    #   0001
    #   0045
    #   1350

Pad the value in `number` with leading zeroes. The padded value will be stored
as a string in `.return$`, and will be `length` charaters long. No check is made
to make sure that no significant digits are lost, so make sure that `length` is
at least long enough to hold the significant digits in `number`.

#### strcount: source$, target$
{: #strcount }

<span></span>{: #numchar }

    @strcount: "Hello world", "l"
    assert strcount.return == 3

Counts the number of occurrences of the `target` string in the `source` string.
The target string can be of any length, and only complete instances in the
source string will be counted. Passing the empty string as `source` is valid,
but will result in no `target` strings being found. The only exception is if the
`target` is the empty string, in which case the result will always be `1`.

#### strcount_regex: source$, pattern$
{: #strcount_regex }

    @strcount: "Hello world", "[rl]"
    assert strcount.return == 4

Like [`strcount`](#strcount), but using regular expressions for the matching.

#### toLower: string$
{: #tolower }

    @toLower: "WORLD"
    assert toLower.return$ == "world"

Converts a string to lowercase. The converted string is stored in `.return$`.

#### toUpper: string$
{: #toupper }

    @toUpper: "hello"
    assert toUpper.return$ == "HELLO"

Converts a string to upercase. The converted string is stored in `.return$`.

#### hasGUI ()
{: #hasgui }

    @hasGUI()
    if hasGUI.return
      appendInfoLine: "Has a GUI"
    else
      appendInfoLine: "Does not have a GUI"
    endif

Detects whether Praat is running with a graphical user interface (GUI) or not.
Praat normally has a GUI, and those cases are normally interactive sessions,
meaning that there is a user who is able to make decisions. But Praat can also
run in "batch" mode, without a GUI, and also in "non-interactive" mode.

This procedure can detect which of this is the case. The value stored in
`.return` will be true ( `!= 0`) if there is a GUI, or false (`== 0`) otherwise.

#### normalPrefDir ()
{: #normalprefdir }

Praat stores the name of its [preferences directory][] in the
`preferencesDirectory$` variable. However, the name of the preferences directory
will depend on the name of the Praat executable, and will also have
platform-dependent separators.

[preferences directory]: http://www.fon.hum.uva.nl/praat/manual/preferences_directory.html

Use of this procedure is not necessary in most cases, particularly after Praat
5.4.15, which added the option to specify a preferences directory. But it might
still be useful in some cases.

The procedure replaces the contents of `preferencesDirectory$`. Use
[@restorePrefDir](#restoreprefdir) to restore the original value of this
variable.

#### restorePrefDir ()
{: #restoreprefdir }

Undoes the changes made by [@normalPrefDir](#normalprefdir).

### `try.proc`

#### try: code$
{: #try }

    @try: "Play"
    # or
    call try
      ... Copy: extractWord$(selected$(), " ") + "_copy" \n
      ... Reverse                                        \n

    if try.catch
      appendInfoLine: "An error was encountered, but we sailed past it"
    endif

Error handling in Praat is limited, and is mostly restricted exclusively to
the use of the `nowarn` and `nocheck` directives, which swallow all warnings
and errors respectively. However, these can only be applied under certain
circumstances, and can only apply to a specific line.

The `@try` procedure takes a single string of code (which could be a single
line or a block of code represented by a string containing separating
newlines) and executes that in a safe manner, such that even if execution of
those lines crashes due to some unexpected reason, the execution of the
larger script will not.

Any changes in the selection that result from the _successful_ completion of
the code passed as the argument to `@try` will be kept. Otherwise, the
selection active at the time `@try` was called will be restored.

Objects created during execution of failing code will be removed
automatically. If this is not desirable, this behaviour can be modified by
setting the `try.remove_on_fail` variable to a false value.

Control variables are also provided to make it easy to check whether any
errors were encountered. The `.return` variable will be true if the code
executed without errors, and false otherwise. For convenience, a separate
variable `.catch` is provided with the opposite meaning: true on error,
false on success.

Despite the name of the variable, it is not possible at this point to
actually _catch_ the error. All this procedure does it to make it possible
to `nocheck` larger blocks of code.

Since the code that is passed to `@try` is executed by a separate instance
of the interpreter, the variables in that code will exist on an entirely
separate scope from the rest of the script, and will not be available in the
calling script. Likewise, the script that is "tried" will not have access
to the variables in the calling script.

It is not possible also to pass arguments to the tried code. To bypass this
issue, save them in an object (a Strings or a Table object might be
suitable) and read them from there.

### `trace.proc`

#### trace: message$
{: #trace }

    include path/to/trace.proc
    @trace: "Not printed"

    trace.enable = 1
    @trace: "Printed to STDOUT"

    trace.output$ = preferencesDirectory$ + "/praat.log"
    @trace: "Append " + string$(number) + " to a file"

Prints a trace message, either to STDOUT or to a file. Because of the way
procedures parse their arguments, the message passed to `@trace` must be a
single string, which means that any number-to-string conversion must be done
manually.

The behaviour of this procedure is controlled at runtime by a number of
different global flags:

`trace.enable`
  : If true, the procedure prints the message. Otherwise, this procedure
    does nothing. False by default.
`trace.output$`
  : The filename of an external trace file. If empty, the trace is printed
    to the Info window (or STDOUT) instead. Empty by default.
`trace.cleared`
  : If false, the device (file or Info window) will be cleared before
    printing the next message. Otherwise, messages will be appended. By
    default, it is set to true when priting to a file, and false otherwise.
`trace.level`
  : In addition to `trace.enable`, the procedure will only print when this
    variable has a value greater than 1. This is useful for dynamically
    increasing or decreasing the verbosity of a script. Set to 1 by default.

The default values of these flags mean that, unless action is taken, this
procedure will produce no output.

### `require.proc`

#### require: version$
{: #require }

    @require: "5.4.22"
    assert praatVersion >= 5422

Makes sure the current version is at least a certain version. If the current
Praat version is lower than the one specified, the procedure will halt the
calling script with a useful error message.

Praat version strings are parsed by [`@semver`](#semver), and compared with
the [`@semver_compare`](#semver_compare) procedure.

#### semver_compare: a$, b$
{: #semver-compare }

<span></span>{: #comparesemver }
<span></span>{: #comparepraatversionstrings }

Compares two version strings like those used by Praat, with three version
numbers separated by periods, or more generally, compatible with the
[_semantic versioning_][semver] standard. In this case, to accommodate
Praat's version numbers, fewer than three components are acceptable
(eg `10.4` is acceptable, and greater than `10.3.192`).

The labels are compared last, and a version without labels is greater than
one with a label. Version metadata is not taken into consideration.

The result of the comparison is stored in `.return`, which will be 0 if the
strings are equal, -1 if the first is greater, and 1 if the second is.

[semver]: http://semver.org/

#### semver: a$
{: #semver }

Parses a version string as a semantic versioning string. These have three
integer components separated by periods (eg. 3.2.38). In this case,
providing fewer than three is acceptable, in which case missing numbers
will be assigned 0 by default.

A label can be attached at the end separated from the numeric components
with a hyphen. Acceptable characters in the label are those matching
[a-zA-Z0-9-] (eg. 8.0.2-Label-with-hyphens)

Build metadata can be appended separated from the rest of the components
with a plus sign (+). Acceptable metadata characters are those matching
[a-zA-Z0-9.-] (eg. 1.2.3+za.sd-65AF4D87B2, 1.3.4-label+metadata)

If given a non-parseable string, this procedure will stop execution.

### `check_filename.proc`

#### checkFilename: name$, label$
{: #checkfilename }

    form Test...
      sentence Read
      comment Leave empty for GUI selector
    endform
    @checkFileame: read$, "Select file to read..."
    assert checkFilename.name$ != ""

For use with initial forms. This procedure provides a GUI-selector with the
label specified in `label$` if `name$` is the empty string. If the user cancels
the GUI-selector, the scrpit ends. Otherwise, the name of the selected file will
be stored in `.name$`.

This procedure calls `chooseReadFile$()` internally.

#### checkWriteFile: name$, label$, file$
{: #checkwritefile }

    form Test...
      sentence Save
      comment Leave empty for GUI selector
    endform
    @checkWriteFile: save$, "Select file to write..."
    assert checkWriteFile.name$ != ""

Similar to [@checkFilename](#checkfilename), but using `chooseWriteFile$()`
internally instead.

### `check_directory.proc`

#### checkDirectory: name$, label$
{: #checkdirectory }

    form Test...
      sentence Directory
      comment Leave empty for GUI selector
    endform
    @checkDirectory: directory$, "Select directory..."
    assert checkDirectory.name$ != ""

Similar to [@checkFilename](#checkfilename), but using `chooseDirectory$()`
internally instead.

### `time.proc`

#### time
{: #time }

    @time()
    if time.year >= 2015
      appendInfoLine: "We don't need any... roads"
    else
      appendInfoLine: "We need roads"
    endif

Praat uses the `date$()` function to return the date as a pre-formatted string.
This procedure calls `date$()` and passes it to [@parseTime](#parsetime) to
separate it into formattable chunks.

#### parseTime: date$
{: #parsetime }

    @time()
    @parseTime: date$()
    assert time.hr == parseTime.hr

This procedure takes a string like those returned by `date$()` and processes it
to provide a set of easily formattable chunks. These are:

`.dw`
  : day of the week (1-7)

`.dw$`
  : day of the week as string (`"Monday"`, ...)

`.dm`
  : day of the month (1-31)

`.mo`
  : month (1-12)

`.mo$`
  : month as string (`"January"`, ...)

`.yr`
  : year (Gregorian)

`.tm$`
  : time as string (`"00:00:00"`)

`.hr`
  : hours (0-24)

`.mn`
  : minutes (0-60)

`.sc`
  : seconds (0-60)

`.date$`
  : the full standard Praat date, as returned by `date$()`

### `base_conversions.proc`

#### hex2dec: num$
{: #hex2dec }

    @hex2dec: "10"
    assert hex2dec.n == 16

Convert a hexadecimal (base 16) number (in `num$`) to decimal. The result will
be stored in `.n` as a numeric.

#### oct2dec: num$
{: #oct2dec }

    @oct2dec: "10"
    assert oct2dec.n == 8

Convert an octal (base 8) number (in `num$`) to decimal. The result will be
stored in `.n` as a numeric.

#### bin2dec: num$
{: #bin2dec }

    @bin2dec: "10"
    assert bin2dec.n == 2

Convert a binary (base 2) number (in `num$`) to decimal. The result will be
stored in `.n` as a numeric.

#### dec2hex: num
{: #dec2hex }

    @dec2hex: 16
    assert dec2hex.n$ == "10"

Convert a decimal (base 10) number (in `num`) to hexadecimal (base 16). The
result will be stored in `.n$` as a string.

#### dec2oct: num
{: #dec2oct }

    @dec2oct: 8
    assert dec2oct.n$ == "10"

Convert a decimal (base 10) number (in `num`) to octal (base 8). The result will
be stored in `.n$` as a string.

#### dec2bin: num
{: #dec2bin }

    @dec2bin: 2
    assert dec2bin.n$ == "10"

Convert a decimal (base 10) number (in `num`) to binary (base 2). The result
will be stored in `.n$` as a string.

#### n2dec: num$, base
{: #n2dec }

    @n2dec: "10", 12
    assert n2dec.n == 12

Interpret a string (in `num$`) as a number in base-`base` and convert it to
decimal (base 10). The result will be stored in `.n` as a numeric.

#### dec2n: num, base
{: #dec2n }

    @dec2n: 12, 12
    assert dec2.n$ == "10"

Convert a decimal (base 10) number (in `num`) to a base-`base` number. The
result will be stored in `.n$` as a string.
