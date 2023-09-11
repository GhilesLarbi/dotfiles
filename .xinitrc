#!/bin/sh

# Get the current tty
#current_tty=$(tty | sed 's/\/dev\///')

exec bspwm
