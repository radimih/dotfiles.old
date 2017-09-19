#!/bin/sh
#-------------------------------------------------------------------------------
# Настройка клавиатуры в X-сессии через подсистему xkb
# ----------------------------------------------------
#
#-------------------------------------------------------------------------------
DEVICE_ID=`xinput --list --short | grep -Po '.*Mouse.*id=\K(\d+)'`
STATUS_NOW=`xinput --list-props $DEVICE_ID | grep -Po 'Device Enabled.+:\s+\K(\d+)'`

if [ "$STATUS_NOW" = "0" ]
then
    xinput --enable $DEVICE_ID
else
    xinput --disable $DEVICE_ID
fi
