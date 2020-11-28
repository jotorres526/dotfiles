#!/bin/bash

rofi_command="rofi -theme themes/powermenu.rasi"

### Options ###
suspend=""
power_off=""
reboot=""
log_out=""
# Variable passed to rofi
options="$suspend\n$power_off\n$reboot\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu)"
case $chosen in
    $suspend)
        systemctl suspend
	    ;;
    $power_off)
        poweroff
        ;;
    $reboot)
        reboot
        ;;
    $log_out)
	    pkill -9 -u $USER
	    ;;
esac

