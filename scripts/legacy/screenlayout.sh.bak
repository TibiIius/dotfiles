#!/bin/sh

MONITOR_HDMI=$(xrandr --listmonitors | grep HDMI-A-1)
MONITOR_DVI=$(xrandr --listmonitors | grep DVI-D-0)

if [ -n "$MONITOR_DVI" ] && [ -n "$MONITOR_HDMI" ]; then
  xrandr --output DisplayPort-0 --off --output DisplayPort-1 --primary --mode 1920x1080 --rate 144 --pos 1920x0 --rotate normal --output HDMI-A-0 --off --output HDMI-A-1 --mode 1920x1080 --pos 0x0 --left-of DisplayPort-1 --rotate normal --output DVI-D-0 --mode 1280x1024 --pos 3840x0 --rate 75 --right-of DisplayPort-1 --rotate normal
else
  xrandr --output DisplayPort-0 --off --output DisplayPort-1 --primary --mode 1920x1080 --rate 144 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output HDMI-A-1 --off --output DVI-D-0 --off
fi

