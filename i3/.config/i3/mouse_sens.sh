#!/bin/bash

DEVICE_ID="$(xinput | grep -i 'mouse' | sed 's/.*id=\([0-9]\+\).*/\1/')"
DEFAULT_MAT='1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000'
MY_MAT='0.08, 0.000000, 0.000000, 0.000000, 0.08, 0.000000, 0.000000, 0.000000, 1.000000'
PROP_MAT="$(xinput list-props 12 | egrep -i 'Transformation Matrix' | sed -n -e 's/.*Matrix (\([0-9]\+\)):\s*\(.*\)/\1;\2/p')"
PROP_ID="$(echo $PROP_MAT | cut -d';' -f1)"
CURRENT_MAT=$(echo $PROP_MAT | cut -d';' -f2)
if [[ "$CURRENT_MAT" == "$DEFAULT_MAT"  ]]; then
  xinput set-prop $DEVICE_ID $PROP_ID $MY_MAT
else
  xinput set-prop $DEVICE_ID $PROP_ID $DEFAULT_MAT
fi
