---
layout: page
group: pod
title: colour
---
{% include JB/setup %}

This plugin converts between Praat's colour format, and the more standard
hexadecimal, RGB and HSV formats.

## Scripts

#### Colour (hex): hex$
{: #colour-hex }

Similar to the standard [**Colour...**][praat colour] command, this command takes a six-digit hexadecimal colour code and sets that as the colour to use with commands from the [Pen menu][].

#### Colour (hsv): h, s, v
{: #colour-hsv }

Similar to the standard [**Colour...**][praat colour] command, this command takes three arguments: the hue (as a number between 0 and 360), the saturation (as a number between 0 and 100), and the _value_ (as a number between 0 and 100). The colour specified by these values is then set as the colour to use with commands from the [Pen menu][].

#### Colour (rgb): r, g, b
{: #colour-rgb }

Similar to the standard [**Colour...**][praat colour] command, this command takes three arguments corresponding to the red, green, and blue components of a colour (as numbers between 0 and 255). The colour specified by these values is then set as the colour to use with commands from the [Pen menu][].

#### Paint circle (hex): hex$, x, y, radius
{: #paint-circle-hex }

Similar to the standard **Paint circle...** command, this commands paints a circle with the specified `radius` at the position in the screen identified by the given coordinates (in the `x` and `y` arguments).

In this case, the first argument specifies the colour to paint the circle as a six-digit hexadecimal code.

#### Paint circle (hsv): h, s, v, x, y, radius
{: #paint-circle-hsv }

Similar to the standard **Paint circle...** command, this commands paints a circle with the specified `radius` at the position in the screen identified by the given coordinates (in the `x` and `y` arguments).

In this case, the first three argument specify the colour to paint the circle with the colour's hue, saturation and value.

#### Paint circle (rgb): r, g, b, x, y, radius
{: #paint-circle-rgb }

Similar to the standard **Paint circle...** command, this commands paints a circle with the specified `radius` at the position in the screen identified by the given coordinates (in the `x` and `y` arguments).

In this case, the first three argument specify the colour to paint the circle with the colour's red, green, and blue components.

#### Paint circle (mm) (hex): hex$, x, y, radius
{: #paint-circle-mm-hex }

This command is the same as [**Paint circle (hex)...**](#paint-circle-hex), but the radius is specified in milimeters.

#### Paint circle (mm) (hsv): h, s, v, x, y, radius
{: #paint-circle-mm-hsv }

This command is the same as [**Paint circle (hsv)...**](#paint-circle-hsv), but the radius is specified in milimeters.

#### Paint circle (mm) (rgb): r, g, b, x, y, radius
{: #paint-circle-mm-rgb }

This command is the same as [**Paint circle (rgb)...**](#paint-circle-rgb), but the radius is specified in milimeters.

#### Paint rectangle (hex): hex$, x1, x2, y1, y2
{: #paint-rectangle-hex }

Similar to the standard **Paint rectangle...** command, this commands paints a rectangle extending horizontally from `x1` to `x2`, and vertically from `y1` to `y2`.

In this case, the first argument specifies the colour to paint the circle as a six-digit hexadecimal code.

#### Paint rectangle (hsv): h, s, v, x1, x2, y1, y2
{: #paint-rectangle-hsv }

Similar to the standard **Paint rectangle...** command, this commands paints a rectangle extending horizontally from `x1` to `x2`, and vertically from `y1` to `y2`.

In this case, the first three argument specify the colour to paint the circle with the colour's hue, saturation and value.

#### Paint rectangle (rgb): r, g, b, x1, x2, y1, y2
{: #paint-rectangle-rgb }

Similar to the standard **Paint rectangle...** command, this commands paints a rectangle extending horizontally from `x1` to `x2`, and vertically from `y1` to `y2`.

In this case, the first three argument specify the colour to paint the circle with the colour's red, green, and blue components.

#### Paint rounded rectangle (hex): hex$, x1, x2, y1, y2, radius
{: #paint-rounded-rectangle-hex }

Similar to the standard **Paint rounded rectangle...** command, this commands paints a rectangle extending horizontally from `x1` to `x2`, and vertically from `y1` to `y2`. The rectangle's corners are rounded according to the value in `radius`.

In this case, the first argument specifies the colour to paint the circle as a six-digit hexadecimal code.

#### Paint rounded rectangle (hsv): h, s, v, x1, x2, y1, y2, radius
{: #paint-rounded-rectangle-hsv }

Similar to the standard **Paint rounded rectangle...** command, this commands paints a rectangle extending horizontally from `x1` to `x2`, and vertically from `y1` to `y2`. The rectangle's corners are rounded according to the value in `radius`.

In this case, the first three argument specify the colour to paint the circle with the colour's hue, saturation and value.

#### Paint rounded rectangle (rgb): r, g, b, x1, x2, y1, y2, radius
{: #paint-rounded-rectangle-rgb }

Similar to the standard **Paint rounded rectangle...** command, this commands paints a rectangle extending horizontally from `x1` to `x2`, and vertically from `y1` to `y2`. The rectangle's corners are rounded according to the value in `radius`.

In this case, the first three argument specify the colour to paint the circle with the colour's red, green, and blue components.

#### Paint ellipse (hex): hex$, x1, x2, y1, y2
{: #paint-ellipse-hex }

Similar to the standard **Paint ellipse...** command, this commands paints an ellipse contained in the rectangle extending horizontally from `x1` to `x2`, and vertically from `y1` to `y2`.

In this case, the first argument specifies the colour to paint the circle as a six-digit hexadecimal code.

#### Paint ellipse (hsv): h, s, v, x1, x2, y1, y2
{: #paint-ellipse-hsv }

Similar to the standard **Paint ellipse...** command, this commands paints an ellipse contained in the rectangle extending horizontally from `x1` to `x2`, and vertically from `y1` to `y2`.

In this case, the first three argument specify the colour to paint the circle with the colour's hue, saturation and value.

#### Paint ellipse (rgb): r, g, b, x1, x2, y1, y2
{: #paint-ellipse-rgb }

Similar to the standard **Paint ellipse...** command, this commands paints an ellipse contained in the rectangle extending horizontally from `x1` to `x2`, and vertically from `y1` to `y2`.

In this case, the first three argument specify the colour to paint the circle with the colour's red, green, and blue components.

## Procedures

### `rainbow.proc`

#### rainbow: number, saturation, value
{: #rainbow }

Generates a series of evenly-spaced colours with as many elements as specified in the `number` argument. The generated colours share the same `saturation` and `value`, as interpreted in the HSV colour format.

The colours are stored as Praat colour strings in the `.colours$` internal indexed variable.

### `hex2hsv.proc`

#### hex2hsv: hex$
{: #hex2hsv }

Takes a six-digit hexadecimal colour code (with or without the preceding hash) and calculates the HSV components that describe that same colour. The generated components are stored in the `.h`, `.s`, and `.v` internal variables as numbers between 0 and 360 for the hue, and between 0 and 100 for the saturation and value.

The hexadecimal code is case-insensitive.

### `hex2praat.proc`

#### hex2praat: hex$
{: #hex2praat }

Takes a six-digit hexadecimal colour code (with or without the preceding hash) and generates the Praat colour string used in the standard praat commands. This string contains the red, green, and blue components of the colour as values between 0 and 1, separated by commas and between curly brackets. The colour string is stored in the `.colour$` internal variable.

The hexadecimal code is case-insensitive.

### `hex2rgb.proc`

#### hex2rgb: hex$
{: #hex2rgb }

Takes a six-digit hexadecimal colour code (with or without the preceding hash) and calculates the RGB components that describe that same colour. The generated components are stored in the `.r`, `.g`, and `.b` internal variables as values between 0 and 255.

The hexadecimal code is case-insensitive.

### `hsv2hex.proc`

#### hsv2hex: h, s, v
{: #hsv2hex }

Takes the hue (0-360), saturation (0-100), and value (0-100) that define a colour in the HSV format and calculates the six-digit hexadecimal code that describes that same colour. The generated colour code is stored in the `.hex$` internal variable, in lowercase characters and with a leading hash.

### `hsv2praat.proc`

#### hsv2praat: h, s, v
{: #hsv2praat }

Takes the hue (0-360), saturation (0-100), and value (0-100) that define a colour in the HSV format and calculates the Praat colour string used in the standard praat commands. This string contains the red, green, and blue components of the colour as values between 0 and 1, separated by commas and between curly brackets. The colour string is stored in the `.colour$` internal variable.

### `hsv2rgb.proc`

#### hsv2rgb: h, s, v
{: #hsv2rgb }

Takes the hue (0-360), saturation (0-100), and value (0-100) that define a colour in the HSV format and calculates the RGB components that describe that same colour. The generated components are stored in the `.r`, `.g`, and `.b` internal variables as values between 0 and 255.

### `rgb2hex.proc`

#### rgb2hex: r, g, b
{: #rgb2hex }

Takes the red, green, and blue components of a colour in the RGB format (as numbers between 0 and 255) and calculates the six-digit hexadecimal code that describes that same colour. The generated colour code is stored in the `.hex$` internal variable, in lowercase characters and with a leading hash.

### `rgb2hsv.proc`

#### rgb2hsv: r, g, b
{: #rgb2hsv }

Takes the red, green, and blue components of a colour in the RGB format (as numbers between 0 and 255) and calculates the HSV components that describe that same colour. The generated components are stored in the `.h`, `.s`, and `.v` internal variables as numbers between 0 and 360 for the hue, and between 0 and 100 for the saturation and value.

### `rgb2praat.proc`

#### rgb2praat: r, g, b
{: #rgb2praat }

Takes the red, green, and blue components of a colour in the RGB format (as numbers between 0 and 255) and calculates the Praat colour string used in the standard praat commands. This string contains the red, green, and blue components of the colour as values between 0 and 1, separated by commas and between curly brackets. The colour string is stored in the `.colour$` internal variable.

### `praat2hex.proc`

#### praat2hex: colour
{: #praat2hex }

Takes a colour described using the Praat colour string used in the standard Praat commands and calculates the six-digit hexadecimal code that describes that same colour. The generated colour code is stored in the `.hex$` internal variable, in lowercase characters and with a leading hash.

### `praat2hsv.proc`

#### praat2hsv: colour
{: #praat2hsv }

Takes a colour described using the Praat colour string used in the standard Praat commands and calculates the HSV components that describe that same colour. The generated components are stored in the `.h`, `.s`, and `.v` internal variables as numbers between 0 and 360 for the hue, and between 0 and 100 for the saturation and value.

### `praat2rgb.proc`

#### praat2rgb: colour
{: #praat2rgb }

Takes a colour described using the Praat colour string used in the standard Praat commands and calculates the RGB components that describe that same colour. The generated components are stored in the `.r`, `.g`, and `.b` internal variables as values between 0 and 255.

[praat colour]: http://www.fon.hum.uva.nl/praat/manual/Colour.html
[pen menu]: http://www.fon.hum.uva.nl/praat/manual/Pen_menu.html
