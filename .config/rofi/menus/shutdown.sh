#!/bin/sh

entry1="⏼  LOGOUT"
entry2="  REBOOT"
entry3="  SHUTDOWN"

chosen=$(printf "$entry1\n$entry2\n$entry3" | rofi -dmenu -i -theme-str '@import "shutdown.rasi"')

case "$chosen" in
	$entry1) pkill -u $USER ;;
	$entry2) systemctl reboot ;;
	$entry3) systemctl poweroff ;;
	*) exit 1 ;;
esac
