#!/bin/sh

APPOINTMENTS_TODAY=$(calcurse -a)

if [ -n "$APPOINTMENTS_TODAY" ]; then
	notify-send "$(calcurse -a)"
	
	while true; do
		calcurse-caldav > /dev/null 2>&1
		APPOINTMENT=$(calcurse -n | awk -F '[][]'  '/\[/ { print $2 }')
		if [ $APPOINTMENT == '01:00' ]; then
		notify-send "Next Appointment: $(calcurse -n | awk '/\]/ { print $2 }')" "in an hour."
		fi
		sleep 60
	done;
else
	notify-send "No Appointments Today" "Be free! :D"
	while true; do
		calcurse-caldav > /dev/null 2>&1
		sleep 60
	done
fi
