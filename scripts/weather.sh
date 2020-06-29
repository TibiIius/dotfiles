#!/bin/sh

while true; do
	echo "$(curl -s wttr.in/Kiel?format="%C+%t")"
done
