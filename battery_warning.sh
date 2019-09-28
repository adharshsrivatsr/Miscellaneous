#!/bin/sh
# This shell script will warn if the battery level goes below 20%.
# A cronjob should be set to make this running at the background for every 5 minutes. 

state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state:" | awk '{print $2}')

if [ $state != "charging" ]; then
	val=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0  | grep 'percentage' | awk '{print substr($2,1,length($2)-1)}')
	thresh=20
	if [ $val -le $thresh ]; then
		/usr/bin/zenity --error --text="Battery level low!" --title="Warning"
	fi
fi
