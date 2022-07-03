#!/usr/bin/bash

# Terminate already running bar instances
# killall -q polybar;
# If all your bars have ipc enabled, you can also use
polybar-msg cmd quit

count=0;
monitor_count=0;

BARS=("fullbar" "secondarybar");

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    let "monitor_count = monitor_count+1"
done

if [ $monitor_count -gt 1 ]; then
    BARS=("primarybar" "secondarybar");
    EXTRA_BARS=("primarybar_mid");
fi

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if  [ $count -lt 2 ];  then
        MONITOR=$m polybar -r ${BARS[count]} 2>&1 | tee -a /tmp/polybar$count.log & disown
        if [ $count -eq 0 ];  then
            MONITOR=$m polybar -r ${EXTRA_BARS[count - 1]} 2>&1 | tee -a /tmp/polybar_extra$count.log & disown
        fi

        let "count = count+1"
    fi
  done
else
  polybar --reload example &
fi

# Launch bar1 and bar2
# echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."

# Reset eww
eww kill
eww daemon

# run feh
./.fehbg
