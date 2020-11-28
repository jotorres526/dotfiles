#!/bin/bash

# Run app only if not open
function run {
    if ! pgrep $1
    then
        $@&
    fi
}

# cursor active at boot
xsetroot -cursor_name left_ptr &

# Starting utilities
run nitrogen --restore &                 # redraw wallpaper
libinput-gestures-setup start            # touchpad gestures
run xfce4-power-manager &                # powermanager
run xfce4-screensaver &                  # screensave and lock
run picom &                              # cool transparency and shadows owo
run parcellite &                         # Clipmanager
run unclutter-xfixes &                   # hide mouse when inactive
run /usr/lib/xfce4/notifyd/xfce4-notifyd # Notifications daemon

# Autostart apps
run discord &
run syncthing --no-browser &
