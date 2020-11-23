#!/bin/bash

# Run app only if not open
function run {
    if ! pgrep $1
    then
        $@&
    fi
}

#change keyboard layout
#setxkbmap -layout pt

# cursor active at boot
xsetroot -cursor_name left_ptr &

# starting utilities
run nitrogen --restore &   # redraw wallpaper           # network manager applet
run xfce4-power-manager &
numlockx on &
run compton &
run unclutter-xfixes & # hide mouse inactivity
#/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & # authentication dialog
#/usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd &
## Started xfce4-notifyd as a systemctl service, but will comment out for future reference

# Autostart apps
run discord &
run syncthing --no-browser &
