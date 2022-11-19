#!/usr/bin/env bash

CONTAINERS=$(distrobox list | tail -n +2 | rg -o "\|.*?\|" | sed 's/|//g;s/^[ \t]//;s/[ \t]*$//') || (echo "No Distrobox containers found!" && exit 0)

PS3="Choose a distro: "

select CONTAINER in $CONTAINERS; do
  break
done

distrobox enter $CONTAINER
