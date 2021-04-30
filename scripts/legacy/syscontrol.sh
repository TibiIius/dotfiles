#!/bin/sh

MENU="$(rofi -theme /home/tim/.dotfiles/config/rofi/current-syscontrol.rasi -sep "|" -dmenu -i <<< " Lock| Logout| Reboot| Shutdown")"
dwm=$( ps -o pid,cmd ax | awk '/dwm/{ if ($2 == "dwm") print $1 }' )

case "$MENU" in
	*Logout) [[ ! -z "$dwm" ]] && kill -s TERM $dwm ;;
	*Lock) i3lock -B sigma --indicator -k --insidecolor=a3be8c44 --insidevercolor=88c0d0aa --insidewrongcolor=fe4151ff --ringvercolor=88C0D0aa --ringcolor=a3be8caa --ringwrongcolor=fe4151ff --keyhlcolor=a3be8cff --bshlcolor=fe4151ff --wrongtext="BAKA\!" --pass-media-keys --pass-volume-keys ;;
	*Reboot) reboot ;;
	*Shutdown) shutdown -h now ;;
esac
