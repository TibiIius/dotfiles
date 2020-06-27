#!/bin/sh

MENU="$(rofi -sep "|" -dmenu -i -p 'What do you want to do?' <<< " Lock| Reboot| Shutdown")"

case "$MENU" in
	Lock) slock ;;
	Reboot) reboot ;;
	Shutdown) poweroff ;;
esac
