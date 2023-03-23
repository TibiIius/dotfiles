#!/bin/sh

MENU="$(rofi -theme /home/tim/.dotfiles/config/rofi/current-syscontrol.rasi -sep "|" -dmenu -i <<< " Reboot| Shutdown")"
dwm=$( ps -o pid,cmd ax | awk '/dwm/{ if ($2 == "dwm") print $1 }' )

case "$MENU" in
	*Reboot) reboot ;;
	*Shutdown) shutdown -h now ;;
esac
