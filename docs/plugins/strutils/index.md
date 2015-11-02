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
file...`][praat raw strigns] command.

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

#### Extract strings: regex$
{: #extract-strings }

#### Create Strings as file list (full path): name$, path$, glob$, keep
{: #file-list-full-path }

#### Create Strings as directory list (full path): name$, path$, glob$, keep
{: #directory-list-full-path }

#### Create Strings as file list (recursive): name$, path$, glob$, depth, sort
{: #file-list-recursive }

#### Create Strings as directory list (recursive): name$, path$, glob$, depth, sort
{: #directory-list-recursive }

#### Replace strings: search$, replace$, regex
{: #replace-strings }

#### Find in Strings: search$, regex
{: #find-in-strings }

#### Sort (generic): numeric, case
{: #sort-generic }

## Procedures

### `create_empty_strings.proc`

#### createEmptyStrings: name$
{: #create-empty-strings-procedure }

### `directory_list_full_path.proc`

#### directoryListFullPath: name$, path$, glob$, keep
{: #directory-list-full-path-procedure }

### `file_list_full_path.proc`

#### fileListFullPath: name$, path$, glob$, keep
{: #file-list-full-path-procedure }

### `find_in_strings.proc`

#### findInStrings: search$, regex
{: #find-in-strings-procedure }

### `replace_strings.proc`

#### replaceStrings: search$, replace$, regex
{: #replace-strings-procedure }

### `extract_strings.proc`

#### extractStrings: regex$
{: #extract-strings-procedure }
