---
layout: page
group: pod
title: htklabel
---
{% include JB/setup %}

Label files used by HTK/HTS and related software packages represent a similar
data structure to Praat TextGrid objects. The scripts in this plugin allow for
the conversion between label files and TextGrid objects, there and back.

## Reading files

This plugin provides features to import HTK/HTS label files into Praat. Mainly,
this is done through two commands, both available under the `Open` menu in the
Objects window.

The command `Read HTK Label File...` takes the path to a single label file and
will read that into one or more TextGrid objects. The mapping between these two
is done so that levels are mapped to tiers and alternatives are mapped to
separate TextGrid objects. After the command, all newly created objects will be
selected.

Currently, only labels that provide both a start and an end position are
supported.

Master Label Files can be read with the `Read HTK Master Label File...`, which
works differently. Since MLF files specify a mapping between filename patterns
and files, reading one into Praat will result in a Table object with the
information necessary for that mapping. Queries are then performed _on_ this
object with the `Query path from MLF Table...` command available in the
contextual menu.

Patterns in MLF files typically use fileglobs, but since in Praat it is more
typical to use regular expressions for this purpose, this command supports both.

The query command takes a filename pattern to match, and a value specifying
how the pattern should be interpreted: either `"Regex"` or `"Glob"`.

If supported, the matched file will then be read into Praat, and any newly
created objects will be selected. Please note that this mapping can point to
_any_ file, not only those used by HTK / HTS.

## Writing files

TextGrid objects can be written to HTK / HTS labels using the
`Save as HTK Label file...`. At this point, converting MLF Table objects to MLF
files is not supported.

In the conversion from TextGrid to label files, only non-empty labels are
taken into account.

Note that only information that can be stored in the selected TextGrid objects
will be saved into the label file. This will _not_ include any coments that may
have been there originally.
