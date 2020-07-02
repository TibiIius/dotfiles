#!/bin/sh

calcurse-caldav > /dev/null 2>&1

sleep 10

APPOINTMENTS_TODAY=$(calcurse -a)

if [ -n "$APPOINTMENTS_TODAY" ]; then
	notify-send "$(calcurse -a)"
else
	notify-send "No Appointments Today" "Be free! :D"
fi
	
while true; do
	calcurse-caldav > /dev/null 2>&1
	APPOINTMENT=$(calcurse -n | awk -F '[][]'  '/\[/ { print $2 }')
	if [ "$APPOINTMENT" == '01:00' ] || [ "$APPOINTMENT" == '00:59' ]; then
	notify-send "Next Appointment: $(calcurse -n | awk '/\]/ { print $2 }')" "in an hour."
	fi
	sleep 60
done;
