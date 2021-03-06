---
layout: page
group: pod
title: json
---
{% include JB/setup %}

## Overview

## Scripts

#### Read JSON file: path$
{: #read-json-file }

## Procedures

### `read.proc`

#### read_json .json$
{: #read-json }

Read a JSON string and map its data to a set or String and Table objects
representing JSON lists and objects respectively. Regardless of how many
of these are created, the ID of the root object will be stored in the
`.return` internal variable.

#### read_json_pair: .json$
{: #read-json-pair }

Read a JSON pair.

#### read_json_value: .json$
{: #read-json-value }

Read a JSON value.

#### read_json_next: .consume, .q$, .s$
{: #read-json-next }

Read the next token in a string, and optionally consume it. The token can
be specified either as a literal string or as a regular expression. The
choice between these is done automatically by the procedure: a string is
considered a regular expression pattern if it is enclosed in slashes (`/`) and
contains at least one non-slash character in between. All other strings will
be interpreted as literals.

The procedure will automatically remove any whitespace characters at the
beginning of the input string.

#### read_json_bailout: .msg$
{: #read-json-bailout }

Cleanly abort parsing a JSON string.

### `write.proc`

#### write_json
{: #write-json }

Executed with a selected Table object (ideally, one prepared by [`@hash`](#hash) and
populated by a procedure such as [`@keyval`](#keyval)), or a Strings object (likewise
prepared by [`@array`][array] and populated by procedures like [`@push`][push]), this
procedure prints the contents of those objects as a JSON serialised string
to the Info window (or STDOUT).

The values in those objects can be marked as the reference to another
existing Table (ie. object) or Strings (ie. list) by using the [`@keyref`](#keyref)
procedure to append the reference as a value in a Table, or the `@pushref`
or [`@unshiftref`](#unshiftref) procedures to do so with lists.

Values are marked as references by being suffixed with an "ID carat".
By default, this is set to the hash character (#), but this can be changed
(see below). When a value is identified as a reference, an object-specific
procedure is called to handle that object: if the reference is to a "Table"
object the procedure called is [`@table_to_json`](#table-write_json); if the object is a
"PointProcess" object, the procedure called will be `@pointprocess_to_json`;
and so on.

The procedures for Tables (hashes) and Strings (lists) are provided by this
file, but the user is free to implement procedures for other objects if
needed. It is recommended, however, that those procedures use the
procedures in `hash.proc` and [`array.proc`][strutils] to populate the appropriate
Table or Strings objects, and then run `@write_json` to print them. The
`@write_json` procedure can be safely called recursively, to handle these
cases.

For algorithmic efficiency, when a Table has multiple rows it will be
treated by `@write_json` as a list of similar objects. This avoids the overhead
involved in having to create multiple Tables with similarly named columns,
and a Strings object to hold their references.

The specific formatting of the JSON output is controlled by a series of
global variables. in particular:

* `json.indent$`: the string to use for one level of indentation if output
  is not minified (defaults to `tab$`)
* `json.minify`: if true, eliminate all non-meaningful whitespace from
  output
* `json.precision`: the maximum precision of numeric values
* `json.undef$`: the string to use for undefined values (defaults to "null"
  as a bare string, native to JSON)
* `json.empty_is_undef`: if true, empty values are printed as null values;
  otherwise they are printed as empty strings
* `json.ignore_undef`: if true, null values are not printed
* `json.empty_lists`: if true, Tables are printed as lists, regardless of
  the number of rows
* `json.id_carat$`: the string suffix used to identify a value as an object
  reference

[push]: http://cpran.net/docs/plugins/strutils/#push
[array]: http://cpran.net/docs/plugins/strutils/#array
[strutils]: http://cpran.net/docs/plugins/strutils

#### keyref: .key$, .ref
{: #keyref }

Works in the same way as [`@keyval`](#keyval), but automatically marks the stored
value as the reference to an existing object.

#### pushref: .ref
{: #pushref }

Works in the same way as [`@push`][push], but automatically marks the stored value
as the reference to an existing object.

#### unshiftref: .ref
{: #unshiftref }

Works in the same way as [`@unshift`][unshift], but automatically marks the stored
value as the reference to an existing object.

[unshift]: http://cpran.net/docs/plugins/strutils/#unshift

#### table_to_json
{: #table-write_json }

This procedure handles the printing of Table objects as a JSON string. The
procedure expects a Table formatted like those generated by the procedures
in `hash.proc`.

#### strings_to_json
{: #strings-write_json }

This procedure handles the printing of Strings objects as a JSON string.
The procedure expects a Strings object, ideally one generated by the
procedures in [`array.proc`][strutis].

#### write_json_start: .type$
{: #write-json-start }

Handle the beginning of a JSON object or list.

#### write_json_end: .type$
{: #write-json-end }

Handle the end of a JSON object or list.

#### write_json_key: .key$
{: #write-json-key }

Prints a JSON key.

#### write_json_val: .val
{: #write-json-val-numeric }

Prints a JSON numeric value.

#### write_json_val$: .val$
{: #write-json-val-string }

Prints a JSON string value.

#### write_json_string: .str$
{: #write-json-string }

Print a JSON string

#### write_json_indent
{: #write-json-indent }

Increase indentation of JSON output

#### write_json_deindent
{: #write-json-deindent }

Decrease indentation of JSON output

### `json.proc`

#### remove_deeply
{: #remove-deeply }

Remove the current top level object representation, and all internally linked
references.

#### remove_table_deeply
{: #remove-table-deeply }

Called internally to remove a hash Table object, and all its internal
references.

#### remove_strings_deeply
{: #remove-strings-deeply }

Called internally to remove a array Strings object, and all its internal
references.

#### json_isReference: .val$
{: #json-isreference }

Internal procedure to check whether a given value stores a reference. The check
is done by matching agains the current value of the `json.id_carat$` variable.

### `hash.proc`

In the same way that the `array.proc` file in the `strutils` plugin provides
array support using Strings objects as a substitute, these procdures provide
conveniency procedures for treating Table objects as hashes.

#### hash: .key$, .val
{: #hash }

Creates a Table object which contains a subset of the strings
of an original Strings object. Search query is a literal string. For
regular expression matching, use
[`@extractStrings_regex`](#extract-strings-regex-procedure).

The new Strings object will be selected after execution.

#### keyval: .key$, .val
{: #keyval-numeric }

Insert a numeric key / value pair to the first row in the current hash-like
Table.

#### keyval$: .key$, .val$
{: #keyval-string }

Insert a string key / value pair to the first row in the current hash-like
Table.

#### delete: .key$
{: #delete }

Delete a key from the current hash-like Table. All the values in that column
will be lost.

### `vars.proc`

This file encapsulates all the variables used for encoding and decoding JSON.
The variables listed below are shown with their default values. Modifying these
can have unexpected consequences.

#### For JSON input

`json.string$` :
  """([^""\\]|\\[""\\/bfnrt]|\\u[0-9a-fA-F]{4})*"""

`json.number$` :
  "[-+]?([1-9][0-9]*(\.[0-9]+)?|0(\.[0-9]+)?)([eE][-+]?[0-9]+)?"

`json.true$` :
  "true"

`json.false$` :
  "false"

`json.null$` :
  "null"

`json.object_start$` :
  "{"

`json.object_end$` :
  "}"

`json.array_start$` :
  "["

`json.array_end$` :
  "]"

`json.max_depth` :
  undefined

#### For JSON output

`json.indent$` :
  tab$

`json.minify` :
  0

`json.precision` :
  undefined

`json.undef$` :
  "null"

`json.empty_is_undef` :
  0

`json.ignore_undef` :
  0

`json.empty_lists` :
  0

`json.id_carat$` :
  "#"
