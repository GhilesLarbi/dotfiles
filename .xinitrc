#!/bin/sh

#load .Xresources db
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

#start bspwm
exec bspwm
