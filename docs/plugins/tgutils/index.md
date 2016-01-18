---
layout: page
group: pod
title: tgutils
---
{% include JB/setup %}

This plugin provides commands and procedures to make it easier to perform
some basic TextGrid tasks:

* Count points in range
* Find labels from beginning or end
* Equalize tier durations
* Explode TextGrid intervals
* Move boundaries to zero-crossings
* Find non-overlapping intervals
* Save as Audacity labels
* Index all labels in a TextGrid

## Scripts

#### Count points in range: tier, start, end
{: #count-points-in-range }

Given a point tier, this script counts the number of points within a given time
range, specified by the `start` and `end` arguments. The result is printed to
the Info window.

This script internally calls the [`@countPointsInRange`](#count-points-in-range-procedure)
procedure.

#### Explode TextGrid: tier, preserve
{: #explode-textgrid }

Using the intervals in the specified interval `tier`, this script splits the
current TextGrid into interval-sized smaller parts. The second argument (a
boolean value) determines whether the resulting fragments will preserve the time
stamps of the original TextGrid or not.

If the script is run with a TextGrid and a Sound object selected, the Sound
object will also be split along the interval boundaries in the specified tier.

The resuting objects will be selected.

#### Extract labels: tier, padding, preserve, search$, regex, replace
{: #extract-labels }

Similar to commands like _Extract intervals where..._, this script is intended
to be run on combinations of TextGrid and Sound objects, to extract fragments of
the Sound objects that correspond to specific intervals in the TextGrid object.

However, the standard commands simply rename the extracted Sounds with the name
of the corresponding interval, which often will result in a possibly large
number of Sound objects with the same name. To prevent confusions, this script
attempts to number each segment so that each occurence of the same label will be
uniquely identifiable. This counting extends across selected objects, such that
multiple instances of intervals with the same label across various Sound objects
will all be numbered sequentially.

The extracted intervals will be those in the tier specified by the `tier`
argument whose labels match the `search$` query (which may be a regular
expression, in which case the value of `regex` should be set to `true`). The
resulting Sound objects will preserve the time stamps of the original Sound if
the `preserve` argument has been set to `true`.

Additionally, the script provides methods to fine-tune the conversion between
the interval labels and the object names, since Praat object names only accept a
limited set of characters, which are often insufficient to accurately represent
the labels in a TextGrid object.

This is controlled by the `replace` argument, which can have one of three
possible values:

* _Make no replacements_, in which case no replacements are made;

* _Use script replacements_, to use the pre-defined conversions in the script
  (or any that may have been added in the `@replaceCharacters` internal
  procedure);

* _Use external definition_, which uses an external CSV file with two columns
  and no headers, in which the string literals in the first column will be
  replaced by the strings in the second.

#### Find label from start: tier, target$, start
{: #find-label-from-start }

Searches through the labels in a given `tier` (either an interval or a point
tier) in the selected TextGrid, and provides the index of the first occurrence
of `target$` after the item whose index matches that in the `start` argument. A
negative value will be counted from the end (the `-1` interval is the last one).

The result will be printed to the Info window. If no label is found, the result
will be `0`.

#### Find label from end: tier, target$, start
{: #find-label-from-end }

Similar to [Find label from start...](#find-label-from-start), this script will
perform a label search in the selected TextGrid. However, the search in this
case will find the first label _before_ the index specified in the `start`
argument. Like in the other script, a negative value will be counted from the
end (the `-1` interval is the last one).

The result will be printed to the Info window. If no label is found, the result
will be `0`.

#### Find label: tier, target$, direction, start
{: #find-label }

This script searches through the labels in a TextGrid `tier` (which may be an
interval or point tier), looking for the first occurrence of the label specified
as `target$`. The search will begin from the item whose index matches the
`start` argument, and move forwards or backwards depending on the value of the
`direction` argument (which may be `"Forwards"` or `"Backwards"`).

The result will be printed to the Info window. If no label is found, the result
will be `0`.

#### Get tier by name: name$
{: #tier-by-name }

Prints the index of the first tier in the selected TextGrid whose name matches
that stated by `name$`. The result will be printed to the Info window. If no tier
is found, the result will be `0`.

#### Index specified labels: tier, target$, regex
{: #index-labels }

Calling [Find label...](#find-label) internally, this script generates a Table
object with a list of all the intervals or points in the tier specified by
`tier` that match the `target$` string. This string can be a regular expression,
in which case the value of the `regex` argument must be set to `true`.

The `index` column in the resulting table will hold the index of the matching
interval or point in the original tier, while the `label` column will have the
matching label. Timing information for points will be stored in a single `time`
column, while intervals will use a `start` and an `end` column.

If no matching labels are found, an empty Table is returned.

#### Make tier times equal
{: #equal-tier-times-script }

This command makes sure the tiers in each of the selected TextGrid objects have
tiers the same duration. This command should not be necessary under normal
conditions, but TextGrid objects that are generated as the combination of
multiple independent tiers can sometimes introduce these differences, and there
is no way in the standard toolkit to check or fix this situation. That's the
void this command fills.

Upon execution, this command makes all tiers have the duration of the longest
tier. This command has no effect if the tiers already have the same length.

#### Move to zero-crossings: tier, maximum, points
{: #move-to-zero-crossings }

Executed with a selected Sound and TextGrid object, this command moves the
boundaries in the tier specified by the `tier` argument to the nearest
zero-crossing in the Sound object (the point in time at which the wave crosses
the zero line). If the value in `tier` is zero, all tiers will be c onsidered.

The value in the `maximum` argument can be used to limit the
magnitude of this time shift, such that no boundaries will be shifted by more
than the specified number of milliseconds. A value of zero means no limit.

If the specified tier is a point tier (instead of an interval tier) the command
will have no effect unless the `points` argument is set to true (ie, is not
`0`). The rationale behind this safeguard is that points are normally meant to
mark specific points in time, and are not often required to match
zero-crossings.

#### To non-overlapping intervals
{: #non-overlapping }

Executed on a TextGrid object, this command generates a new TextGrid object with
a single interval tier, generated as if all the interval tiers in the original
object had been flattened into one. Two overlapping labeled intervals (in
different tiers) of the original object will produce three intervals in the new
object: one for the intersection, and one for the part of each original interval
that did not overlap.

The intervals in the new object will be labeled according to whether or not they
correspond to the intersection of two or more labeled intervals in the original
object: if they are not, their label will be the number of the original tier
they were from; if they are, they will be labeled with a `0`.

    Original TextGrid
    -----------------

    |        |                   |                   |
    |        |        A          |                   | Alice
    |                    |                    |      |
    |                    |          B         |      | Bob

    New TextGrid
    ------------

    |        |           |       |            |      |
    |        |     1     |   0   |     2      |      | overlaps

This is particularly useful when the TextGrid stores the multiple turns in an
interaction, with the utterances of each speaker in a different tier (a common
enough setup). This command can help identify the fragments of the interaction
in which each speaker is speaking on their own.

#### TextGrid tier to Audacity label track: tier, path$, info
{: #audacity-tier }

Executed on a TextGrid object, this command converts the specified `tier` into
a file in the format used by [Audacity][] to store labels. Audacity labels are
represented within Audacity as a single track, which fulfills a similar role to
the tiers in a TextGrid. This is why only a single tier can be converted at any
one time. To convert an entire TextGrid with multiple tiers, the command will
have to be run independently on each.

If the value in the `info` argument is set to true (ie, has a non-zero value),
the label file will be printed to the Info screen (or to STDOUT if running in
non-interactive mode), and the value of the `path$` argument will be ignored
Otherwise, the `path$` argument will be used to specify where the label is to be
saved.

If multiple TextGrid objects are selected when the command was run, the value in
`path$` is expected to be a directory, where the multiple labels will be saved.
If a single TextGrid object was selected, the `path$` will specify the target
file where the label is to be saved.

### Batch scripts

**These scripts are only available when the [vieweach][] plugin is installed.**

#### Make tier times equal: from$, to$
{: #equal-tier-times-batch }

Equalise the duration of tiers in all TextGrid objects in the path specified in
`from$`, and save the equalised TextGrids to the path in `to$`. This command
calls [Make tier times equal](#equal-tier-times-script) internally.

#### Move to zero-crossings: sound$, textgrid$, output$, tier, maximum, points
{: #move-to-zero-crossings-batch }

Similar to the [Move to zero crossings...](#move-to-zero-crossings) command,
this command will read the TextGrid files in the path in `textgrid$` and the
Sound files in the path in `sound$` and adjust the position of the boundaries.
The resulting TextGrids will be saved to the directory specified in `output$`.

#### TextGrids in directory to Audacity labels: path$, tier, info
{: #audacity-tier-batch }

This command will read all the TextGrid files in the path specified in `path$`
and convert the tiers specified in `tier` to Audacity labels. They will either
be saved as independent files in the source directory, or if the value in
`info` is set to true, printed to the Info window (or STDOUT if in a
non-interactive session).

## Procedures

### `count_points_in_range.proc`

#### countPointsInRange: tier, start, end
{: #count-points-in-range-procedure }

Given a `tier` number, and a time range with the `start` and `end` arguments,
this procedure counts the number of points that exist in that tier within that
time range.

### `find_label.proc`

Procedures defined in this file make it possible to look for specific labels
(for either points or intervals) in the entire TextGrid, or from a given time
point forwards or backwards.

By default, the target strings to match are interpreted as regular expressions,
for added versatility. This can be disabled by setting the global variable
`find_label.regex` to false (ie, `0`), which will make the target strings become
string literals. Setting this to a non-zero value reverts this change.

#### findLabel: tier, target$
{: #find-label }

Looks for the first point or interval in the tier specified in the `tier`
argument whose label matches the one specified in `target$`. This procedure
starts at the first element in the TextGrid, and continues forward until one is
found.

The index of the found element is stored in the `.return` internal variable. If
no matching element was found, this variable will be set to `0`.

#### findNthLabel: tier, target$, index
{: #find-nth-label }

Similar to [@findLabel](#find-label), this procedure looks for intervals or
points in the specified `tier` whose labels match the `target$`. However,
instead of stopping at the first matching element, it will continue until it
has found as many matching labels as were specified in the `index` argument.

Calling this procedure with an index of `1` is the same as calling
[@findLabel](#find-label). Calling it with an index of `0` returns an undefined
value.

The index of the found element is stored in the `.return` internal variable. If
no matching element was found, this variable will be set to `0`.

#### findLabelAhead: tier, target$, from
{: #find-label-ahead }

Similar to [@findLabel](#find-label), this procedure looks for intervals or
points in the specified `tier` whose labels match the `target$`. However,
instead of starting at the first element in the TextGrid, it starts at the
element whose index matches the one specified in the `from` argument.

The index of the found element is stored in the `.return` internal variable. If
no matching element was found, this variable will be set to `0`.

#### findLabelBehind: tier, target$, from
{: #find-label-behind }

Similar to [@findLabel](#find-label), this procedure looks for intervals or
points in the specified `tier` whose labels match the `target$`. However,
instead of searching forward from the first element to the last, it starts at
the element whose index matches the one specified in the `from` argument, and
searches backwards.

The index of the found element is stored in the `.return` internal variable. If
no matching element was found, this variable will be set to `0`.

### `get_tier_by_name.proc`

#### getTierByName: target$
{: #tier-by-name-procedure }

Given a string in the `target$` argument, this procedure looks for a tier in the
selected TextGrid whose names matches that string. In Praat, multiple TextGrid
tiers can have the same name. If that is the case, this procedure returns the
index of the first matching one.

The target string is interpreted as a string literal. The index of the found
tier is stored in the `.return` variable. If no matching tier was found, this
variable is set to `0`.

### `make_tier_times_equal.proc`

#### makeTierTimesEqual
{: #equal-tier-times-procedure }

Called internally by [Make tier times equal...](#equal-tier-times-script), this
procedure holds the logic used by that command to equalise the tier durations.

### `move_to_zero_crossings.proc`


#### moveToZeroCrossings: tier, maximum
{: #move-to-zero-crossings-procedure }

Called internally by [Move to zero-crossings...](#move-to-zero-crossings), this
procedure holds the logic used by that command to adjust the timestamps of the
desired elements.

Note that the procedure _does not care_ whether the specified `tier` is an
interval or a point tier. The safeguard to not move points is implemented in the
command described above.

### `textgrid_to_audacity_labels.proc`

#### tierToAudacityLabel: tier, out$
{: #audacity-tier-procedure }

Called internally by [TextGrid tier to Audacity label track...](#audacity-tier),
this procedure holds the logic used by that command to convert the specified
`tier` to the format expected by [Audacity][].

The procedure will save the generated Audacity label file in the path specified
in the `out$` argument. If this is the empty string, the generated label will be
printed to the Info window (or STDOUT if in a non-interactive session).

### `to_non-overlapping_intervals.proc`

#### toNonOverlappingIntervals
{: #non-overlapping-procedure }

Called internally by [To non-overlapping intervals...](#non-overlapping), this
procedure holds the logic used by that command to flatten the TextGrid's tiers.

[vieweach]: http://cpran.net/plugins/vieweach
[audacity]: http://audacityteam.org
