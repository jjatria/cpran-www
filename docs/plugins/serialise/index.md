---
layout: page
group: pod
title: serialise
---
{% include JB/setup %}

*serialise* allows for the serialisation and de-serialisation of Praat objects
using JSON or YAML standards.

Working with Praat normally means interacting with several different types
of objects, representing different abstractions within the program.
However, the way in which Praat saves these to disk is highly
idiosyncratic, and although there are some non-Praat parsers written for
the most common object types, they have limitations.

This plugin attempts to solve this by allowing the serialisation and
deserialisation of most Praat object types into either YAML or JSON. The
benefit of using these serialisation standards is that their use is
widespread, and parsers and validators are everywhere.

Included in the plugin are Perl scripts to handle the heavy-lifting of the
conversion, and Praat wrappers to facilitate the reading and writing of
serialised files from within the Praat GUI. For this plugin to work, Perl is
required, as well as the following Perl modules:

* Path::Class
* Readonly
* YAML::XS
* JSON
* File::HomeDir
* Try::Tiny

### A note on text-output encodings

Because of the particulars of the processing of files by Perl, the text files
created by Praat need to be in UTF-8 encoding for these scripts to work. A set
of [procedures](#procedures) are provided mostly for internal use to try and
make this work even in cases in which different output preferences are in
effect, but these are admittedly fragile.

To avoid problems, make sure that your writing preferences are set to UTF-8
text output.

## Scripts

#### Save as serialised text file: filename$, output$, format$, pretty
{: #serialise }

This script saves the selected objects as a JSON or a YAML text file, as
specified in the `output$` argument, which can have the values `"YAML"` or
`"JSON"`. The name of the resulting file is taken from the string passed as the
`filename$` argument.

Praat uses its own format for text serialisation, and this includes a special
type of Object which represents a collection of other objects of possibly
multiple different types. Not surprisingly, these objects are of type
"Collection". However, this special type becomes unnecessary when using YAML
or JSON since both of these standards already have the ability of representing
collections of multiple objects.

By default, when working on a set of objects, the underlying Perl scripts will
write a file which represents a list of objects, and not a single Collection
object representing the entire set. However, this will not work if multiple objects of the same name are saved (since the object's name is used as the name
of the serialised object as well). For these cases, this behaviour can be
changed with the `format$` argument, which can have the values `"Data stream"`
(for saving each object as part of the same stream) or `"Collection"` (for
saving a single Collection object).

The JSON serialiser takes an additional optional argument controlling whether
the output should be "pretty-printed" (the default), meaning that it will be
properly indented and broken into lines; or "minified", which uses the least
amount of space by doing away with spaces and line breaks. This can be
controlled with the `pretty` boolean variable.

This command is not available through the GUI, but can be found in the
`serialise.praat` file.

#### Save as JSON: filename, format, pretty
{: #save-as-json }

A shortcut to [Save as serialised text file...](#serialise), this script will
call that command with the value of the `output$` variable already set to
`"JSON"`. The behaviour of the rest of the arguments is the same in both cases.

This command is available through the Write menu when the selected objects are
all of a single supported type. Otherwise, it is available through the CPrAN
menu under Praat > CPrAN > serialise.

#### Save as YAML: filename, format
{: #save-as-yaml }

A shortcut to [Save as serialised text file...](#serialise), this script will
call that command with the value of the `output$` variable already set to
`"YAML"`. The behaviour of the rest of the arguments is the same in both cases.

This command is available through the Write menu when the selected objects are
all of a single supported type. Otherwise, it is available through the CPrAN
menu under Praat > CPrAN > serialise.

#### Read from JSON/YAML: filename$
{: #deserialise }

This script takes the name of a YAML or JSON file (in `filename$`) and reads
the object (or objects) it represents into the object list in Praat.

This command can be accessed at any time from the Read menu.

## Procedures

### `preferences.proc`

#### saveOutputPreferences()
{: #save-output-preferences }

{% highlight praat %}
@saveOutputPreferences()
{% endhighlight %}

This procedure tries to save the existing text-output preferences. Their value
is stored in the `.output$` variable.

#### restoreOutputPreferences()
{: #restore-output-preferences }

{% highlight praat %}
@restoreOutputPreferences()
{% endhighlight %}

This procedure tries to restore the text-writing preferences to what they were
when the serialisation scripts were first run, if they were not `"UTF-8"`.

#### checkOutputPreferences()
{: #check-output-preferences }

{% highlight praat %}
@checkOutputPreferences()
{% endhighlight %}

This procedure provides an interface for the user to correct their text output
preferences if they are found not to be set to `"UTF-8"`. The user is given the
possibility of aborting execution, setting their preferences permanently to the
required value, or setting them temporarily, such that at the end of
serialisation the attempt is made to restore them to what they were.
