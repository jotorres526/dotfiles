#!/bin/bash
# volume output for xmobar
vol=$(amixer -D pulse sget Master | awk -F'[]%[]' '/%/ {if ($5 == "off") { print "MM" } else { print $2 }}' | head -n 1)

if [ $vol == "MM" ]
then
    output="Audio is Muted"
else
    output="Volume: $vol%"
fi

echo -e $output

exit 0
