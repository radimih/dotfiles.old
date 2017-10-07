#!/bin/sh
#-------------------------------------------------------------------------------
# Включить/отключить тачпад
# -------------------------
#
#-------------------------------------------------------------------------------
DEVICE_ID=`xinput --list --short | grep -Po '.*Mouse.*id=\K(\d+)'`
STATUS_NOW=`xinput --list-props $DEVICE_ID | grep -Po 'Device Enabled.+:\s+\K(\d+)'`

if [ "$STATUS_NOW" = "0" ]
then
    touchpad-on.sh
else
    touchpad-off.sh
fi
