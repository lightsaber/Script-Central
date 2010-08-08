#!/bin/bash

# Worklog polls the system for information on what you are actively working on at any given time.
#
#  DEPENDENCIES
#    1. dbus - for the interface to gnome-screensaver
#    2. gnome-screensaver - provides API for monitoring status
#    3. xprop - gives the window name for active windows 
#


export host=$(hostname)
export output_dir="${HOME}/.worklog"
export LOGFILE="${output_dir}/worklog-${host}-`date +%Y`"
export POLL_FREQUENCY=5

function log
{
    app=$1
    shift
    time=$(date +"%j - %H:%M:%S")
    echo "| $time | $(hostname) | $app | $*" >> $LOGFILE
}

function check_ignores
{
    # Ignores tell the script what status to log when encountering a specific application
    #  This matches on the application name
    if [ -e ~/.worklog/ignores ]; then
        #stub for later
        #IGNORED=0
        echo ""
    fi

    IGNORED=1
}

# Traps handle what to log in the event of signals
trap 'log "session_end ${USER}" && exit 0' 1 2 3 
trap 'log "system_shutdown ${USER}" && exit 0' 15

# Initialize user directory if one doesn't exist
if [ ! -e $output_dir ]; then
    mkdir $output_dir
fi

stat='0'
IGNORED=1

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

    check_ignores $window_title
    if [ 0 -eq $IGNORED ]; then
        app="idle"
        window_title=""
        IGNORED=1
    fi

    log $app $window_title

    sleep $POLL_FREQUENCY
done
