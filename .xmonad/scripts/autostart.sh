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

# Starting utilities
run nitrogen --restore &      # redraw wallpaper
libinput-gestures-setup start # touchpad gestures
run xfce4-power-manager &     # powermanager
run compton &                 # cool transparency and shadows owo
run unclutter-xfixes &        # hide mouse when inactive

# Autostart apps
run discord &
run syncthing --no-browser &
