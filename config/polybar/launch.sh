#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Bars
polybar primary -c $HOME/.config/polybar/primary-config.ini &
polybar external -c $HOME/.config/polybar/external-config.ini &
# polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
