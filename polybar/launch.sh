#!/usr/bin/bash

# Terminate already running bar instances
killall -q polybar;
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

count=0;
BARS=("primarybar" "secondarybar");

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if  [ $count -lt 2 ];  then
        MONITOR=$m polybar -r ${BARS[count]} 2>&1 | tee -a /tmp/polybar$count.log & disown
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

eww daemon
