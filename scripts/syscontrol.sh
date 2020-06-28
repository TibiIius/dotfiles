#!/bin/sh

MENU="$(rofi -sep "|" -dmenu -i -p 'What do you want to do?' <<< " Logout| Lock| Reboot| Shutdown")"
dwm=$( ps -o pid,cmd ax | awk '/dwm/{ if ($2 == "dwm") print $1 }' )

case "$MENU" in
	*Logout) [[ ! -z "$dwm" ]] && kill -s TERM $dwm ;;
	*Lock) slock ;;
	*Reboot) reboot ;;
	*Shutdown) shutdown -h now ;;
esac
