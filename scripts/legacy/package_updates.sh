#!/bin/bash


while true; do
	UPDATECOUNT="Package Updates: $(checkupdates | wc -l)\nAUR Updates: $(trizen -Syyua --show-ood | wc -l)"
	echo -e $UPDATECOUNT
	sleep 2
done
