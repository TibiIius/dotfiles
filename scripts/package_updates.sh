#!/bin/sh

while true; do
	echo "$(dnf list --upgrades | wc -l)"
done
