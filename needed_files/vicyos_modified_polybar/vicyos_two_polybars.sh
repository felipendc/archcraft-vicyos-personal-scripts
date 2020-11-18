#!/usr/bin/env bash

# Launch the bar
STYLE="vicyos_openbox_two_polybars"

# Launch Polybar for primary monitor LVDS1
bash "$HOME"/.config/polybar/"$STYLE"/primary_lvds1_launch.sh

# Launch Polybar for primary monitor HDMI
bash "$HOME"/.config/polybar/"$STYLE"/secondary_hdmi_launch.sh

