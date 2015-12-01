---
layout: page
group: pod
title: twopass
---
{% include JB/setup %}

This plugin implements De Looze and Hirst's two-pass utterance-specific pitch
threshold estimation algorithm. From [the researcher's website][delooze]:

> In order to avoid possible pitch tracking errors, pitch floor and pitch
> ceiling are set [to `q25 * 0.75` and `q75 * 1.5` (where `q` stands for
> "percentile"), which] have been shown[^1][^2][^3] to give a better estimation
> of pitch extrema, i.e. to exclude more octave errors or microprosodic effects
> at the extreme of the f0 distribution, than setting pitch floor and ceiling
> parameters to the default values [in Praat] or to default values depending
> on the gender of the speaker.

[^1]: De Looze, C. and Hirst, D. (2008) _Detecting changes in key and range for the automatic modelling and coding of intonation_, Speech Prosody.
[^2]: De Looze, C. (2010) _Analyse et interprétation de l'empan temporel des variations prosodiques en français et en anglais contemporain_, Doctoral thesis, Université de Provence.
[^3]: Hirst, D. (2011) _The analysis by synthesis of speech melody: from data to models_, Journal of Speech Sciences 1(1): 55-83.

[delooze]: http://celinedelooze.com/Homepage/Resources.html

The scripts and procedures provided by this plugin are written so that their
main intended objective is the creation of Pitch objects with the estimated
pitch thresholds. In writing them, scripts provided by the researchers in their
[website][delooze] and in the [Praat user's list][praat list] were taken into
consideration.

[praat list]: http://uk.groups.yahoo.com/neo/groups/praat-users/conversations/topics/6199

## Scripts

#### To Pitch (two-pass): floor, ceiling
{: #to-pitch }

This script takes a selection of Sound objects, and applies the algorithm
described above to each in turn to generate a corresponding Pitch object. The
resulting objects are selected at the end.

The parameters passed to the script are the `floor` and `ceiling` factors that
will be multiplied with the first and third quartiles respectively to estimate
the pitch thresholds. A floor factor of `0.75` and a ceiling factor of `1.5` are
recommended by the researchers in most cases, but they warn that for "expressive
speech", a ceiling factor of up to `2.5` might give better results.

Passing zeroes instead of these values uses the recommended default values
instead.

#### Batch to Pitch (two-pass): floor, ceiling, input$, output$
{: #batch-to-pitch }

Similar to [To Pitch (two-pass)...](#to-pitch), this script takes floor and
ceiling factors, and an input and an output path. Designed for batch processing,
this script processes all the sound files in the `input$` directory and saves
the resulting Pitch objects in the `output$` directory.

Passing zeroes as the factors uses the recommended default values.

## Procedures

#### pitchTwoPass: floor, ceiling
{: #pitch-two-pass }

    sound = selected("Sound")
    @pitchTwoPass: 0, 0
    assert numberOfSelected("Pitch") == 1

This procedure has the same effect as the [To Pitch (two-pass)...](#to-pitch)
script described above, and works in the same way. In fact, it is used
internally by all other scripts.

It takes a selected Sound object and generates a Pitch object, which will be
selected after completion. For ease, the ID of that object is also stored in the
`.id` variable.
