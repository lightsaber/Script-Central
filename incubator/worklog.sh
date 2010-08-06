#!/bin/bash

DEBUG=1

# Worklog polls the system for information on what you are actively working on at any given time.
POLL_FREQUENCY=5
stat=''
last_stat=''

function debug 
{
    if [ $DEBUG -eq 0 ]; then 
        echo $0 :: $1
    fi
}

while [ 1 = 1 ]; do
    last_stat=$stat

    #if gnome-screensaver is active, log idle
    #TODO if the app was configurable, you could set up all types of regex matches to not log on
    if [ 0 -lt $(ps aux | grep '\[gnome-screensav\]' | wc -l) ]; then
        stat=0
    else 
        stat=$(xprop -root | sed -nr 's/^_NET_ACTIVE_WINDOW.*\# (.*)/\1/p')
    fi

    debug "stat is $stat"

    if [ "${stat}" = "${last_stat}" ]; then
        #if the same program is running, do nothing
        sleep $POLL_FREQUENCY
        continue;
    fi
    
    debug "${stat} != ${last_stat}"

    if [ "0" = "$stat" ]; then
        debug "IDLE"
        app="idle"
        window_title=""
    else
        app=$(xprop -id ${stat} | sed -nr 's/^WM_CLASS.*\, \"(.*)\".*/\1/p')
        debug "app is $app"
        window_title=$(xprop -id ${stat} | sed -nr 's/^WM_ICON_NAME.*\"(.*)\".*/\1/p')
        debug "title is $window_title"
    fi

    time=$(date +"[%j] | %H:%M")
    echo "$time | $app | $window_title"

    sleep $POLL_FREQUENCY
done
