#!/bin/sh

while true; do
	echo "$(curl -s wttr.in/Rumohr?format="%C+%t")"
done
