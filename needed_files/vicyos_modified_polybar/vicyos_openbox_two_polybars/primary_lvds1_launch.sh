#!/usr/bin/env bash

# Terminate already running bar instances
# killall -q polybar

# # Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar main1 -c $HOME/.config/polybar/vicyos_openbox_two_polybars/config_primary.ini &
