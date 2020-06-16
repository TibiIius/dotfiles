#!/bin/sh

while true; do
	echo "$(checkupdates | wc -l)"
	sleep 2
done
