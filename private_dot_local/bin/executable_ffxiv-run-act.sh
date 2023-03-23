#!/bin/bash

. $HOME/.local/bin/ffxiv-env.sh

cd "$WINEPREFIX/ACT"
wine64 "Advanced Combat Tracker.exe"
