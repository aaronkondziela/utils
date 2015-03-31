#!/usr/bin/env bash
# Aaron's Pinger
# by Aaron Kondziela
# This work is licensed under a Creative Commons Attribution 4.0 International License
# http://creativecommons.org/licenses/by/4.0/

if [ -z "$1" ] ; then
	echo "Error: No target host specified, exiting."
	echo
	echo "Usage: $0 <host_to_ping>"
	echo
	exit 1
fi

IP="$1"

trap ctrl_c INT

function ctrl_c() {
	echo "Got Ctrl-C, exiting."
	exit
}

COLUMNS=`tput cols`
LINES=`tput lines`
echo -n "At the current terminal size of $COLUMNS each line represents "
echo -n `bc <<< "scale=2; $COLUMNS / 60"`
echo -ne " minutes,\nand each screenfull represents "
echo -n `bc <<< "scale=2; ( $LINES * $COLUMNS ) / 60 / 60"`
echo " hours."

GOODPING_COLOR='\033[102m'
BADPING_COLOR='\033[101m'
RESET_COLOR='\033[49m'

while [ 1 ]
do
	if ping -q -c 1 -W 1 "$IP" 1>/dev/null 2>&1
	then
		echo -ne "$GOODPING_COLOR.$RESET_COLOR"
		sleep 1
	else
		echo -ne "${BADPING_COLOR}X$RESET_COLOR"
	fi
done
