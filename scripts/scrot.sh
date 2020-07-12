#!/bin/sh

notify-send 'Select area to screenshot'
sleep 0.1
scrot -s /home/tim/Documents/Screenshots/%d-%m-%Y-%T-scrot.png && notify-send 'Screenshot taken' 'saved in ~/Documents/Screenshots'
