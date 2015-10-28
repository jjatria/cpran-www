# A demonstration of Praat's pitch detection algorithm in R
# Written by Jose J. Atria (January 2012)
# Tested to work with R 2.13.1

# This script is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# A copy of the GNU General Public License is available at <http://www.gnu.org/licenses/>.

# Initial variables

f0 = 140
sample.rate = 44100
periodsPerWindow = 3
x = 1:((1/f0)*sample.rate*periodsPerWindow)

# For saving plots

save_plots <- TRUE
type = 'svg'
ndev <- 1
par(mar=c(5, 4, 3 * !save_plots + 1, 2) + 0.1)
if (save_plots) {
  mydevice <- function (type='svg', width=7, height=4) {
    stopifnot(type %in% c('svg', 'png'))
    name <- paste0('fig', ndev, '.', type, collapse=NULL)
    if (type == 'svg') {
      svg(name, width=width, height=height)
    } else {
      png(name, width=width, height=height, unit='in', res=200)
    }
    ndev <<- ndev + 1
  }
} else {
  mydevice <- function (...) { }
}

# The working sound

sample = (1+0.3*sin(2*pi*f0*x/sample.rate))*sin(2*pi*(f0*2)*x/sample.rate)
sample <- sample / max(sample)
mydevice(type)
plot(sample, type="l", ylab="Intensity", xlab="Samples", main=if (save_plots) { "" } else { "The sound in the analysis window" }, axes=FALSE)
axis(1, at=c(seq(from=0, to=max(x), by=200), max(x)), lwd=0)
axis(2, at=c(-1,0,1), lwd=0)
dev.off()

# The Hanning window filter

filter=0.5-0.5*cos((2*pi*x)/max(x))
mydevice(type)
plot(filter, type="l", ylab="Intensity", xlab="Samples", ylim=c(0,1), main=if (save_plots) { "" } else { "The Hanning filter function" }, axes=FALSE)
axis(1, at=c(seq(from=0, to=max(x), by=200), max(x)), lwd=0)
axis(2, at=c(-1,0,1), lwd=0)
dev.off()

# The filtered sound

filtered = sample*filter
mydevice(type)
plot(filtered, type="l", ylab="Intensity", xlab="Samples", main=if (save_plots) { "" } else { "The filtered window" }, axes=FALSE, ylim=c(-1,1))
axis(1, at=c(seq(from=0, to=max(x), by=200), max(x)), lwd=0)
axis(2, at=c(sprintf("%.2f",min(filtered)),0,sprintf("%.2f",max(filtered))), lwd=0)
dev.off()

# The autocorrelation of the filtered sound

mydevice(type)
r_a = acf(filtered, max(x), xlab="Time lag (in samples)", ylim=c(-1,1), main=if (save_plots) { "" } else { "Normalized autocorrelation of the filtered sound" }, axes=FALSE)$acf
false_peak <- 20+which.max(r_a[21:max(x)])
real_peak  <- (1/f0)*sample.rate
axis(1, at=c(0, false_peak, real_peak, max(x)), lwd=0)
axis(2, at=c(-1,0,1), lwd=0)
abline(v=false_peak, col="red")
abline(v=real_peak, col="blue")
dev.off()

# The autocorrelation of the filter

r_w = (1-(abs(x)/max(x)))*((2/3)+(1/3)*cos((2*pi*x)/max(x)))+(1/(2*pi))*sin((2*pi*abs(x))/max(x))
mydevice(type)
plot(r_w, type="l", ylab="ACF", xlab="Time lag (in samples)", ylim=c(0,1), main=if (save_plots) { "" } else { "Normalized autocorrelation of the window function" }, axes=FALSE)
axis(1, at=c(seq(from=0, to=max(x), by=200), max(x)), lwd=0)
axis(2, at=c(0,1), lwd=0)
dev.off()

# The estimates of the original signal's autocorrelation

r_x = r_a/r_w
r_x.plot <- r_x
r_x.plot[(max(x)/2):(max(x))] <- NA
mydevice(type)
plot(r_x.plot, type="l", ylab="ACF", xlab="Time lag (in samples)", ylim=c(-1,1), main=if (save_plots) { "" } else { "Estimated autocorrelation of the original signal" }, axes=FALSE)
real_peak <- 20+which.max(r_x[21:(max(x)/2)])
abline(v=real_peak, col="blue")
axis(1, at=c(0, real_peak, round(max(x)/2)), lwd=0)
axis(2, at=c(-1,0,1), lwd=0)
dev.off()

# Calculating the f0 from the time lag in samples

result = 1/((20+which.max(r_x[21:(max(x)/2)]))/sample.rate)
cat("f0 = ", result, "\n")

# The original version of this file resides at
# http://pinguinorodriguez.cl/assets/tutorials/praat_pitch/scripts/figures.R
#
# Source of the examples:
# Boersma, P. (1993) Acurate short-term analysis of the fundamental
# frequency and the harmonics-to-noise ratio of a sampled sound.
# IFA Proceedings 17: 97-110
# http://www.fon.hum.uva.nl/paul/papers/Proceedings_1993.pdf
