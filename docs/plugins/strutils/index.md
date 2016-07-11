---
layout: page
group: pod
title: strutils
---
{% include JB/setup %}

A [Strings][] object in Praat is an ordered list of strings that is most
commonly used to represent either lists of files or directories in disk (as
returned by the [`Create Strings as file list...`][praat file list] and [`Create
Strings as directory list...`][praat directory list] standard Praat commands),
or the lines of a text file that was read with the [`Read Strings from raw text
file...`][praat raw strings] command.

[praat file list]: http://www.fon.hum.uva.nl/praat/manual/Create_Strings_as_file_list___.html
[praat directory list]: http://www.fon.hum.uva.nl/praat/manual/Create_Strings_as_directory_list___.html
[praat raw strings]: http://www.fon.hum.uva.nl/praat/manual/Read_Strings_from_raw_text_file___.html
[strings]: http://www.fon.hum.uva.nl/praat/manual/Strings.html

"strutils" provides some new ways to create Strings (including the possibility
of creating an empty Strings object, as well as making fully-specified file and
directory lists), and some commands to manipulate existing objects.

## Scripts

#### Create empty Strings: name$
{: #create-empty-strings }

There is no command regularly available in Praat to create empty Strings,
which can only be created as listings of file contents or entries in the
file structure. To make use of the full benefit of Strings, this command
makes it possible to create Strings that are guarranteed to be empty.

All the processing done by this command is handled internally by the [`@createEmptyStrings`](#create-empty-strings-procedure) procedure.

#### Extract strings: search$, match$, use_regex
{: #extract-strings }

Creates a Strings object which contains a subset of the strings
of an original Strings object. The newly created object is selected
after execution of this script.

#### Create Strings as file list (full path): name$, path$, glob$, keep
{: #file-list-full-path }

Same as `Create Strings as file list...` but with full paths. The
processing of this script is handled internally by
[`@fileListFullPath`](#file-list-full-path-procedure).

#### Create Strings as directory list (full path): name$, path$, glob$, keep
{: #directory-list-full-path }

Same as `Create Strings as directory list...` but with full paths. The
processing of this script is handled internally by
[`@directoryListFullPath`](#directory-list-full-path-procedure).

#### Create Strings as file list (recursive): name$, path$, glob$, depth, sort
{: #file-list-recursive }

Same as
[`Create Strings as file list (full path)...`](#file-list-full-path)
but recursive. Makes a list of all matching files under the specified
directory and any of its subdirectories (up to the specified depth).
The processing of this script is handled internally by
[`@fileListFullPath`](#file-list-full-path-procedure).

#### Create Strings as directory list (recursive): name$, path$, glob$, depth, sort
{: #directory-list-recursive }

Same as
[`Create Strings as directory list (full path)...`](#directory-list-full-path)
but recursive. Makes a list of all matching directories under the specified
directory and any of its subdirectories (up to the specified depth).
The processing of this script is handled internally by
[`@directoryListFullPath`](#directory-list-full-path-procedure).

#### Replace strings: search$, replace$, how_many, regex
{: #replace-strings }

Takes a Strings object and performs a "search and replace" operation upon
it. The modifications are done on a separate Strings object, leaving the
original untouched. The newly generated Strings object is selected after
execution.

The string matching can be done using string literals, which will match if
the occur anywhere in the string or regular expression patterns. This can be
controlled with the `regex` variable. The value of the `how_many` will
determine the maximum number of replacements to perform.

Internally, this script calls
[`@replaceStrings`](#replace-strings-procedure) or
[`@replaceStrings_regex`](#replace-strings-regex-procedure) as appropriate.

#### Find in Strings: search$, regex
{: #find-in-strings }

Run on a single Strings object, this script performs a search for the
specified string (interpreted either as a literal or as a regular expression
pattern) and prints the index of the first found string to the Info window.
If the string was not found, `0` is printed instead.

#### Sort (generic): numeric, case
{: #sort-generic }

Perform a generic sort on a Strings object.

The default `Sort` command for Strings sorts things ASCII-betically, such
that uppercase letters come before lowercase, and numbers are ordered as
if they were words. Since Strings often represent lists of files or
directories, this is often not what one wants, specially in the case of
names starting with numbers.

Ordered ASCII-betically, a list like

    20, a10, Abc, 10, 1, a2, abc, abdce, 2, Ab, a1

would become

    1, 10, 2, 20, Ab, Abc, a1, a10, a2, abc, abdce

A generic sort treats numbers like numbers, and strings like strings, such
that the previous list would be ordered in a much more intuitive way:

    1, 2, 10, 20, Ab, Abc, a1, a2, a10, abc, abdce

The specifics of the ordering can be adjusted with the two boolean
parameters. The first one sets the relative position of numbers (or strings
that look like numbers) as a group, while the second one allows one to do a
case-insensitive sort. As an example, with both values set to false (the
non-default value), the above list would become

    a1, a2, a10, Ab, abc, Abc, abdce, 1, 2, 10, 20

with the relative position of the fifth and sixth terms being unspecified.

## Procedures

### `create_empty_strings.proc`

#### createEmptyStrings: name$
{: #create-empty-strings-procedure }

Creates an empty Strings object. It takes the name of the object to create,
and stores the ID of the created object in the internal `.id` variable.

After execution of this procedure, the newly created object will be selected.

### `directory_list_full_path.proc`

#### directoryListFullPath: name$, path$, glob$, keep
{: #directory-list-full-path-procedure }

Same as `Create Strings as directory list...` but with full paths. This
procedure internally calls that command, and the fate of the Strings
object generated by it will depend on the value of `.keep`. If true, the
object is kept and its ID stored in `.relative`. If false, it is removed
and that variable set to `undefined`.

The selection will include all generated Strings, in which the one with
full paths will be the most recent. The ID of this object will also be
stored in `.id`, and in `.absolute`, for contrast with `.relative`.

### `file_list_full_path.proc`

#### fileListFullPath: name$, path$, glob$, keep
{: #file-list-full-path-procedure }

Same as `Create Strings as file list...` but with full paths. This
procedure internally calls that command, and the fate of the Strings
object generated by it will depend on the value of `.keep`. If true, the
object is kept and its ID stored in `.relative`. If false, it is removed
and that variable set to `undefined`.

The selection will include all generated Strings, in which the one with
full paths will be the most recent. The ID of this object will also be
stored in `.id`, and in `.absolute`, for contrast with `.relative`.

### `find_in_strings.proc`

#### findInStrings: search$, match
{: #find-in-strings-procedure }

Searches for a literal string in a Strings object. For matching with regular
expressions, use
[`@findInStrings_regex`](#find-in-strings-regex-procedure).

#### findInStrings_regex: regex$, match
{: #find-in-strings-regex-procedure }

Searches a Strings object for matches to a regular expression pattern. For
matches with literal strings, use
[`@findInStrings`](##find-in-strings-procedure).

### `replace_strings.proc`

#### replaceStrings: search$, replace$, how_many
{: #replace-strings-procedure }

Takes a Strings object and performs a "search and replace" operation upon
it. The modifications are done on a separate Strings object, leaving the
original untouched.

The string matching is done using string literals (which will match if
the occur anywhere in the string). To use regular expression patterns, use
[`@replaceStrings_regex`](#replace-strings-regex-procedure).

#### replaceStrings_regex: search$, replace$, how_many
{: #replace-strings-regex-procedure }

Takes a Strings object and performs a "search and replace" operation upon
it. The modifications are done on a separate Strings object, leaving the
original untouched.

The string matching is done using regular expression patterns. To use
literal strings, use [`@replaceStrings`](#replace-strings-procedure).

### `extract_strings.proc`

#### extractStrings: query$
{: #extract-strings-procedure }

Creates a Strings object which contains a subset of the strings
of an original Strings object. Search query is a literal string. For
regular expression matching, use
[`@extractStrings_regex`](#extract-strings-regex-procedure).

The new Strings object will be selected after execution.

#### extractStrings_regex: regex$
{: #extract-strings-regex-procedure }

Creates a Strings object which contains a subset of the strings
of an original Strings object. Search query is a regular expression
pattern. For matching with literal strings, use
[`@extractStrings`](#extract-strings).

The new Strings object will be selected after execution.
