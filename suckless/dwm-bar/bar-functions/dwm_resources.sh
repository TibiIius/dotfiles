#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_resources () {
    # Used and total memory
    MEMUSED=$(free -h | awk '(NR == 2) {print $3}')
    MEMTOT=$(free -h |awk '(NR == 2) {print $2}')
    # CPU temperature
#   CPU=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d. -f1)
		CPU=$(top -b -n2 -p 1 | fgrep "Cpu(s)" | tail -1 | awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); printf "%s%.1f%%\n", prefix, 100 - v }')
    # Used and total storage in /home (rounded to 1024B)
    STOUSED=$(df -h | grep '/$' | awk '{print $3}')
    STOTOT=$(df -h | grep '/$' | awk '{print $2}')
    STOPER=$(df -h | grep '/$' | awk '{print $5}')

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf " %s/%s   %s/%s" "$MEMUSED" "$MEMTOT" "$STOUSED" "$STOTOT"
    else
        printf "STA | MEM %s/%s CPU %s STO %s/%s" "$MEMUSED" "$MEMTOT" "$CPU" "$STOUSED" "$STOTOT"
    fi
    printf "%s\n" "$SEP2"
}

dwm_resources
