#!/bin/sh

MENU="$(rofi -theme /home/tim/Documents/GitHub/dotfiles/rofi/current-syscontrol.rasi -sep "|" -dmenu -i <<< " Lock| Logout| Reboot| Shutdown")"
dwm=$( ps -o pid,cmd ax | awk '/dwm/{ if ($2 == "dwm") print $1 }' )

case "$MENU" in
	*Logout) [[ ! -z "$dwm" ]] && kill -s TERM $dwm ;;
	*Lock) slock ;;
	*Reboot) reboot ;;
	*Shutdown) shutdown -h now ;;
esac
