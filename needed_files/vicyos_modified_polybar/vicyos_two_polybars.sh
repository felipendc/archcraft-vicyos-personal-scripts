#!/usr/bin/env bash

# Launch the bar
STYLE="vicyos_openbox_two_polybars"

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar for primary monitor LVDS1
bash "$HOME"/.config/polybar/"$STYLE"/primary_lvds1_launch.sh
sleep 2
# Launch Polybar for primary monitor HDMI
bash "$HOME"/.config/polybar/"$STYLE"/secondary_hdmi_launch.sh

