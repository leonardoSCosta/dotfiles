#!/usr/bin/sh
windows=`echo "eww windows"`
CALENDAR_NAME="calendar"

if $windows | grep -qs "*$CALENDAR_NAME"; then
    eww close $CALENDAR_NAME
else
    eww open $CALENDAR_NAME
fi
