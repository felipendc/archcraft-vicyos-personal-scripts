#!/usr/bin/env bash

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar for primary monitor LVDS1
$HOME/.config/polybar/vicyos_openbox_two_polybars/primary_lvds1_launch.sh

# Launch Polybar for primary monitor HDMI
$HOME/.config/polybar/vicyos_openbox_two_polybars/secondary_hdmi_launch.sh

