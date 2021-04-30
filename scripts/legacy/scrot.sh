#!/bin/sh

if [[ $1 == "area" ]]; then
	notify-send 'Select area to screenshot'
	sleep 0.1
	scrot -s /home/tim/Documents/Screenshots/%d-%m-%Y-%T-scrot.png && notify-send 'Screenshot taken' 'saved in ~/Documents/Screenshots'
elif [[ $1 == "focused" ]]; then
	notify-send 'Focused window will be screenshotted shortly'
	sleep 0.1
	scrot -u /home/tim/Documents/Screenshots/%d-%m-%Y-%T-scrot.png && notify-send 'Screenshot taken' 'saved in ~/Documents/Screenshots'
fi
