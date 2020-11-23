#!/bin/bash
# Formatted weather to display on xmobar
# Check https://github.com/chubin/wttr.in for more documentation on the format
format="Weather:+%C+%t\n"

echo $(curl wttr.in?format="$format")
