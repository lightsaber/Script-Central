#!/bin/bash

# Worklog polls the system for information on what you are actively working on at any given time.
#  The script dumps output to STDOUT so it can be redirected to a log file or to the screen
#
#  DEPENDENCIES
#    1. dbus - for the interface to gnome-screensaver
#    2. gnome-screensaver - provides API for monitoring status
#    3. xprop - gives the window name for active windows 
#


POLL_FREQUENCY=5
stat='0'

while [ true ]; do
    last_stat=$stat

    #If gnome-screensaver is running, assume the system is idle
    xidle=$(dbus-send --session --dest=org.gnome.ScreenSaver --type=method_call --print-reply --reply-timeout=2000 /org/gnome/ScreenSaver org.gnome.ScreenSaver.GetActive | sed -nr 's/^.*boolean (.*)$/\1/p')
    if [ "true" = "$xidle" ]; then
        stat=0
    else 
        stat=$(xprop -root | sed -nr 's/^_NET_ACTIVE_WINDOW.*\# (.*)/\1/p')
    fi

    # if the same app is running, do nothing
    if [ "${stat}" = "${last_stat}" ]; then
        sleep $POLL_FREQUENCY
        continue;
    fi
    
    if [ "0" = "$stat" ]; then
        app="idle"
        window_title=""
    else
        app=$(xprop -id ${stat} | sed -nr 's/^WM_CLASS.*\, \"(.*)\".*/\1/p')
        window_title=$(xprop -id ${stat} | sed -nr 's/^WM_ICON_NAME.*\"(.*)\".*/\1/p')
    fi

    time=$(date +"[%j] | %H:%M")
    echo "$time | $app | $window_title"

    sleep $POLL_FREQUENCY
done
