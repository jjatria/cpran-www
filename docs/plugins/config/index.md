---
layout: page
group: pod
title: config
---
{% include JB/setup %}

Read a hash from a configuration file. Entries are read by separating
each meaningful line at the leftmost occurrence of `.separator$`. The
part on the left will be the key, and what is left on the right will
be its value.

The separator string can be longer than a single character. This
separator is not passed as an argument, but read from the global
workspace. If it does not exist by the time the procedures are included,
it is given the default value of ":".

Lines beginning with a hash character (#), optionally preceeded by
whitespace, are considered comments, and ignored.

For versions after 6.0.16, elements found are stored in the `.return$[]`
string hash. For convenience, a separate `.return[]` hash is provided
with the result of calling `number()` on each corresponding element in
`.return$[]`. For the purposes of generating this numeric hash,
corresponding strings like "yes" and "true" are converted to `1`, while
"no" and "false" are converted to `0`.

In versions before 6.0.16, which do not support hashes, or when requested
by setting `.use_table` to true, a Table representation of a hash is used
_instead_, with a single row, and in which each column is named with the
key of a different entry. Because this approach means there will be a
single hash, boolean strings are not supported when using Tables.
