#!/usr/bin/env sh

choice=$(zenity --list --title "Distrobox selection" --column="Container name" $(distrobox list | tail -n +2 | rg -o "\|.*?\|" | sed 's/|//g;s/^[ \t]//;s/[ \t]*$//') --separator="\S\s")

distrobox enter $choice
