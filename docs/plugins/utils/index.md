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

The `Rename...` command in the standard Praat toolkit only works with a single
selected object and a fully specified name. This command makes it possible to
rename multiple objects in the Object list by specifying the new names as a
regular expression pattern. The command uses Praat's
[regular expressions][regex].

[regex]: http://www.fon.hum.uva.nl/praat/manual/Regular_expressions.html

## Procedures

### `utils.proc`

#### pwgen: length

#### rndstr: length, charset$

#### split: sep$, str$

#### numchar: str$, target$

#### mktemp: template$

#### zeropad: num, length

#### toLower: string$

#### toUpper: string$

#### hasGUI ()

#### normalPrefDir ()

#### restorePrefDir ()

### `require.proc`

#### require: version$

#### comparePraatVersionStrings: a$, b$

### `check_filename.proc`

#### checkFilename: name$, label$

#### checkWriteFile: name$, label$, file$

### `check_directory.proc`

#### checkDirectory: name$, label$

### `time.proc`

#### time

#### parseTime: date$

### `base_conversions.proc`

#### hex2dec: num$

#### oct2dec: num$

#### bin2dec: num$

#### dec2hex: num

#### dec2oct: num

#### dec2bin: num

#### n2dec: num$, base

#### dec2n: num, base
