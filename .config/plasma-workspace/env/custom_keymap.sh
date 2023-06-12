#!/bin/bash

setxkbmap de
setxkbmap -option shift:both_shiftlock
setxkbmap -option ctrl:nocaps
xmodmap ~/.Xmodmap
