#!/bin/bash

DEVICE_ID="$(xinput | grep -i 'zowie' | sed 's/.*id=\([0-9]\+\).*/\1/')"
xinput set-button-map $DEVICE_ID 1 2 3 4 5 6 7 1 9 10 11 12 13 14 15 16
