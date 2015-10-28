# Find closest real (not interpolated) pitch value, both
# directionally or on absolute terms.
# Returns the found pitch value and the time at which it
# was found.
#
# Written by Jose J. Atria (7 March 2012)
# Latest revision: 14 March 2012
# Tested to work with Praat v 5.3.06
#
# This script is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

form Find nearest pitch...
    real Start_from_(s) 0
    optionmenu searching: 1
        option Forward
        option Backwards
        option Bidirectionally
endform

if searching = 2
    delta = -1
elsif searching = 3
    delta = 0
else
    delta = searching
endif
time = start_from

pitch = numberOfSelected("Pitch")
if !pitch
    exit No Pitch object selected
endif

result = Get value at time... time Hertz Nearest
frame = Get frame number from time... time
frame = floor(frame + 0.5)
posOffset = 0
negOffset = 0
offset = 0
foundForward = 0
duration = Get total duration
startFrame = 1
endFrame = Get number of frames
roundDuration = floor(duration*1000)/1000

if time > duration
    exit Time is greater than total duration ('roundDuration's)
elsif time = 0 and delta = -1
    exit Can't search backwards from 0.
elsif duration-time < 0.001 and delta = 1
    exit Can't search forwards from end.
elsif time = 0 and delta = 0
    pause Bidirectional search impossible from start. Performing forward search.
    delta = 1
elsif time = duration and delta = 0
    pause Bidirectional search impossible from end. Performing backwards search.
    delta = -1
endif

clearinfo

# printline Called with delta='delta'
while result = undefined
    if delta >= 0
        # print 'tab$'...searching forward... 
        posOffset += 1
        result = Get value in frame... frame+posOffset Hertz
        if frame+posOffset = endFrame
            result = 0
        endif
        if result = undefined
            foundForward = 0
        else
            foundForward = 1
        endif
        # printline 'result'
    endif
    if delta <= 0 and foundForward != 1
        # print 'tab$'...searching backwards... 
        negOffset -= 1
        result = Get value in frame... frame+negOffset Hertz
        if frame+negOffset = startFrame
            result = 0
        endif
        # printline 'result'
    endif
endwhile

if abs(posOffset) > abs(negOffset)
    offset = posOffset
elsif abs(posOffset) < abs(negOffset)
    offset = negOffset
elsif foundForward
    offset = posOffset
else
    offset = negOffset
endif
foundTime = Get time from frame number... frame+offset

if result
    printline 'result'Hz at 'foundTime:3's (offset: 'offset')
else
    result = undefined
    printline 'result'
endif