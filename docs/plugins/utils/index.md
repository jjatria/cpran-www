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

#### Save selected objects: path, overwrite {: #save-all }

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

#### Rename (regex): pattern, replace {: #rename-regex }

The `Rename...` command in the standard Praat toolkit only works with a single
selected object and a fully specified name. This command makes it possible to
rename multiple objects in the Object list by specifying the new names as a
regular expression pattern. The command uses Praat's
[regular expressions][regex].

[regex]: http://www.fon.hum.uva.nl/praat/manual/Regular_expressions.html

## Procedures

### `utils.proc`

#### pwgen: length {: #pwgen }

    @pwgen: 10
    assert length(pwgen.return$) == 10
    # pwgen.return$ is a random alphanumeric string

This procedure aims to provide similar functionality to the `pwgen(1)` UNIX
command, which generates "pronounceable" random strings. The current version,
however, simply acts as a simplified version of[@rndstr](#rndstr). In the
future this will hopefully change.

The value in `length` specifies the number of characters in the resulting
string, which is stored in `.return$`.

#### rndstr: length, charset$ {: #rndstr }

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

#### split: separator$, string$ {: #split }

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

#### numchar: string$, target$ {: #numchar }

    @numchar: "hello", "l"
    assert numchar.return == 2

Counts the number of occurences of `target$` in `string$`. The result is stored
in `.return`.

#### mktemp: template$ {: #mktemp }

    @mktemp: "somefolderXXXXXX"
    assert fileReadable: mktemp.return$

Similar to the UNIX `mktemp(1)` command, this procedure creates a directory with
a name that is guaranteed to not exist at the time the procedure was called.
This procedure is not thread-safe, but is useful for storing temporary files.
The directory will _not_ be automatically deleted.

The name of the directory is generated based on the contents of `template$`,
which needs to be of the form `baseXXXXX`, in which each `X` character will be
replaced with a random one using a single character from the `"a1"` character
set as defined in [@rndstr](#rndstr). The template must have _at least_ three
random placeholders at the end. If the template is the empty string,
`"tmp.XXXXXXXXXX"` will be used as a default.

The name of the directory is stored in `.return$`, and the directory is created
automatically.

#### zeropad: number, length {: #zeropad }

    @split: ",", "1,45,1350"
    for i to split.length
      @zeropad: number(split.return$[i]), 4
      appendInfoLine: zeropad.return$
    endfor
    # Prints
    #   0001
    #   0045
    #   1000

Pad the value in `number` with leading zeroes. The padded value will be stored
as a string in `.return$`, and will be `length` charaters long. No check is made
to make sure that no significant digits are lost, so make sure that `length` is
at least long enough to hold the significant digits in `number`.

#### toLower: string$ {: #tolower }

    @toLower: "WORLD"
    assert toLower.return$ == "world"

Converts a string to lowercase. The converted string is stored in `.return$`.

#### toUpper: string$ {: #toupper }

    @toUpper: "hello"
    assert toUpper.return$ == "HELLO"

Converts a string to upercase. The converted string is stored in `.return$`.

#### hasGUI () {: #hasgui }

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

#### normalPrefDir () {: #normalprefdir }

Praat stores the name of its preferences directory in the
`preferencesDirectory$` variable. However, the name of the preferences directory
will depend on the name of the Praat executable, and will also have
platform-dependent separators.

Use of this procedure is not necessary in most cases, particularly after Praat
5.4.15, which added the option to specify a preferences directory. But it might
still be useful in some cases.

The procedure replaces the contents of `preferencesDirectory$`. Use
[`@restorePrefDir`](#restoreprefdir) to restore the original value of this
variable.

#### restorePrefDir () {: #restoreprefdir }

Undoes the changes made by [`@normalPrefDir`](#normalprefdir).

### `require.proc`

#### require: version$ {: #require }

    @require: "5.4.22"
    assert praatVersion >= 5422

Makes sure that the current version of Praat is _at least_ equal to that
specified by `version$`. If this requirement is not met, a useful error message
is displayed to the user.

#### comparePraatVersionStrings: a$, b$ {: #comparepraatversionstrings }

Compares two version strings like those used by Praat, with three version
numbers separated by periods. Although all versions of Praat (so far) are
directly comparable using the numeric versions (stored in `praatVersion`), this
procedure will work with any _semantic versioning_ version string
(eg `10.2` is smaller than `10.3.192`).

The comparison is made between the two versions identified by `a$` and `b$`. The
result of the comparison is stored in `.return`, which will be 0 if the strings
are equal, -1 if `a$` is greater, and 1 if `b$` is greater.

### `check_filename.proc`

#### checkFilename: name$, label$ {: #checkfilename }

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

#### checkWriteFile: name$, label$, file$ {: #checkwritefile }

    form Test...
      sentence Save
      comment Leave empty for GUI selector
    endform
    @checkWriteFile: save$, "Select file to write..."
    assert checkWriteFile.name$ != ""

Similar to [`@checkFilename`](#checkfilename), but using `chooseWriteFile$()`
internally instead.

### `check_directory.proc`

#### checkDirectory: name$, label$ {: #checkdirectory }

    form Test...
      sentence Directory
      comment Leave empty for GUI selector
    endform
    @checkDirectory: directory$, "Select directory..."
    assert checkDirectory.name$ != ""

Similar to [`@checkFilename`](#checkfilename), but using `chooseDirectory$()`
internally instead.

### `time.proc`

#### time {: #time }

    @time()
    if time.year >= 2015
      appendInfoLine: "We don't need any... roads"
    else
      appendInfoLine: "We need roads"
    endif

Praat uses the `date$()` function to return the date as a pre-formatted string.
This procedure calls `date$()` and passes it to [`@parseTime`](#parsetime) to
separate it into formattable chunks.

#### parseTime: date$ {: #parsetime }

    @time()
    @parseTime: date$()
    assert time.hr == parseTime.hr

This procedure takes a string like those returned by `date$()` and processes it
to provide a set of easily formattable chunks. These are:

`.dw`
  : day of the week (1-7)
`.dw$`
  : day of the week as string (`"Mon"`, ...)
`.dm`
  : day of the month (1-31)
`.mo`
  : month (1-12)
`.mo$`
  : month as string (`"Jan"`, ...)
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

#### hex2dec: num$ {: #hex2dec }

    @hex2dec: "10"
    assert hex2dec.n == 16

Convert a hexadecimal (base 16) number (in `num$`) to decimal. The result will
be stored in `.n` as a numeric.

#### oct2dec: num$ {: #oct2dec }

    @oct2dec: "10"
    assert oct2dec.n == 8

Convert an octal (base 8) number (in `num$`) to decimal. The result will be
stored in `.n` as a numeric.

#### bin2dec: num$ {: #bin2dec }

    @bin2dec: "10"
    assert bin2dec.n == 2

Convert a binary (base 2) number (in `num$`) to decimal. The result will be
stored in `.n` as a numeric.

#### dec2hex: num {: #dec2hex }

    @dec2hex: 16
    assert dec2hex.n$ == "10"

Convert a decimal (base 10) number (in `num`) to hexadecimal (base 16). The
result will be stored in `.n$` as a string.

#### dec2oct: num {: #dec2oct }

    @dec2oct: 8
    assert dec2oct.n$ == "10"

Convert a decimal (base 10) number (in `num`) to octal (base 8). The result will
be stored in `.n$` as a string.

#### dec2bin: num {: #dec2bin }

    @dec2bin: 2
    assert dec2bin.n$ == "10"

Convert a decimal (base 10) number (in `num`) to binary (base 2). The result
will be stored in `.n$` as a string.

#### n2dec: num$, base {: #n2dec }

    @n2dec: "10", 12
    assert n2dec.n == 12

Interpret a string (in `num$`) as a number in base-`base` and convert it to
decimal (base 10). The result will be stored in `.n` as a numeric.

#### dec2n: num, base {: #dec2n }

    @dec2n: 12, 12
    assert dec2.n$ == "10"

Convert a decimal (base 10) number (in `num`) to a base-`base` number. The
result will be stored in `.n$` as a string.
