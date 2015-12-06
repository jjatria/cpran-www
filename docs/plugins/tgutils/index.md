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

#### Explode TextGrid: tier, preserve
{: #explode-textgrid }

#### Extract labels: tier, preserve
{: #extract-labels }

#### Find label from end: tier, target$, start
{: #find-label-from-end }

#### Find label from start: tier, target$, start
{: #find-label-from-start }

#### Find label: tier, target$, direction, start
{: #find-label }

#### Get tier by name: name$
{: #tier-by-name }

#### Index specified labels: tier, target$, regex
{: #index-labels }

#### Make tier times equal
{: #equal-tier-times }

#### Move to zero-crossings: tier, maximum, points
{: #move-to-zero-crossings }

#### To non-overlappng intervals
{: #non-overlapping }

#### TextGrid tier to Audacity label track: tier, path$, info
{: #audacity-tier }

### Batch scripts

#### Make tier times equal
{: #equal-tier-times }

#### Move to zero-crossings: tier, maximum, points
{: #move-to-zero-crossings }

#### TextGrids in directory to Audacity labels: path$, tier, info
{: #batch-audacity-tier }

## Procedures

### `count_points_in_range.proc`

#### countPointsInRange: tier, start, end

### `find_label.proc`

#### findLabel: tier, target$
{: #find-label }

#### findNthLabel: tier, target$, index
{: #find-nth-label }

#### findLabelAhead: tier, target$, from
{: #find-label-ahead }

#### findLabelBehind: tier, target$, from
{: #find-label-behind }

### `get_tier_by_name.proc`

#### getTierByName: target$
{: #get-tier-by-name-procedure }

### `make_tier_times_equal.proc`

#### makeTierTimesEqual
{: #equal-tier-times }

### `move_to_zero_crossings.proc`

#### moveToZeroCrossings: tier, maximum
{: #move-to-zero-crossings-procedure }

### `textgrid_to_audacity_labels.proc`

#### tierToAudacityLabel: tier, out$
{: #audacity-tier-procedure }

### `to_non-overlapping_intervals.proc`

#### toNonOverlappingIntervals
{: #non-overlapping-procedure }
