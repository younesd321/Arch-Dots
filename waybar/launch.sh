#!/bin/bash
killall -q waybar
while pgrep -x waybar >/dev/null; do sleep 1; done
waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &
echo "Waybar launched..."
