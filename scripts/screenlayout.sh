#!/bin/sh

MONITOR_LEFT=$(xrandr --listmonitors | grep DVI-I-1)
MONITOR_RIGHT=$(xrandr --listmonitors | grep DVI-D-0)

if [ -n "$MONITOR_LEFT" ] && [ -n "$MONITOR_RIGHT" ]; then
	xrandr --output DVI-I-0 --off --output DVI-I-1 --mode 1280x1024 --rate 75 --pos 3840x0 --rotate normal --output HDMI-0 --off --output DP-0 --primary --mode 1920x1080 --rate 144 --pos 1920x0 --rotate normal --output DP-1 --off --output DVI-D-0 --mode 1920x1080 --pos 0x0 --rotate normal
else
	xrandr --output DVI-I-0 --off --output DVI-I-1 --off --output HDMI-0 --off --output DP-0 --primary --mode 1920x1080 --rate 144 --pos 0x0 --rotate normal --output DP-1 --off --output DVI-D-0 --off
fi
