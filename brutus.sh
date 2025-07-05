#!/bin/bash

# read 3 pins to log brunnen status: leer, unterhalb, oberhalb, voll
#____        ____
#oooo|      |oooo
#oooo|      |oooo
#oooo|  X1  |oooo
#oooo|      |oooo
#oooo|      |oooo
#oooo|  X2  |oooo
#oooo|      |oooo
#oooo|      |oooo
#oooo|  X3  |oooo
#oooo|______|oooo
#oooooooooooooooo
#oooooooooooooooo

INPUT="/dev/ttyACM0"


# read brunnen status from device file and trigger status from sub system
read -r -N7 x < $INPUT #& sleep 1; echo "g" > $INPUT


if [ "$x" == "" ]
then
	echo "brutus: failed to read status"
	exit 2
fi

# setze Variablen der aktuellen Belegung
x1=$(echo $x | cut -f1 -d" ")
x2=$(echo $x | cut -f2 -d" ")
x3=$(echo $x | cut -f3 -d" ")

# setze Variablen der gespeicherten Belegung
X1=$(cat /root/apps/brutus/X1)
X2=$(cat /root/apps/brutus/X2)
X3=$(cat /root/apps/brutus/X3)

# vergleichen der Veraenderung der Belegung
if [ $x1 == $X1 ] &&  [ $x2 == $X2 ] && [ $x3 == $X3 ]
then
	exit 1;
fi

# leer
if [ $x1 == "0" ] &&  [ $x2 == "0" ] && [ $x3 == "0" ]
then
	$PINGME telegram --token "$(cat /etc/telegramtoken)" --channel "$(cat /etc/telegramchannel_haus)" --title "Brunnen: LEER" --msg "$(cat /root/apps/brutus/leer)"
	echo -e "leer\t\t$(date +%F)" >> $LOG_FILE
	VAL=1
fi

# unterhalb
if [ $x1 == "0"  ] &&  [ $x2 == "0" ] && [ $x3 == "1" ]
then
	$PINGME telegram --token "$(cat /etc/telegramtoken)" --channel "$(cat /etc/telegramchannel_haus)" --title "Brunnen: UNTERHALB" --msg "$(cat /root/apps/brutus/unterhalb)"
	echo -e "unterhalb\t$(date +%F)" >> $LOG_FILE
	VAL=1
fi

# oberhalb
if [ $x1 == "0" ] &&  [ $x2 == "1" ] && [ $x3 == "1" ]
then
	$PINGME telegram --token "$(cat /etc/telegramtoken)" --channel "$(cat /etc/telegramchannel_haus)" --title "Brunnen: OBERHALB" --msg "$(cat /root/apps/brutus/oberhalb)"
	echo -e "oberhalb\t$(date +%F)" >> $LOG_FILE
	VAL=1
fi

# voll
if [ $x1 == "1" ] &&  [ $x2 == "1" ] && [ $x3 == "1" ]
then
	$PINGME telegram --token "$(cat /etc/telegramtoken)" --channel "$(cat /etc/telegramchannel_haus)" --title "Brunnen: VOLL" --msg "$(cat /root/apps/brutus/voll)"
	echo -e "voll\t\t$(date +%F)" >> $LOG_FILE
	VAL=1
fi

# check if sensor input is valid and save data if true
if [ "$VAL" -ne "1" ]
then
	$PINGME telegram --token "$(cat /etc/telegramtoken)" --channel "$(cat /etc/telegramchannel_haus)" --title "Brunnen: ERROR" --msg "$x1 $x2 $x3: invalid brutus input!"
else
	# save current data
	echo $x3 > /root/apps/brutus/X3
	echo $x2 > /root/apps/brutus/X2
	echo $x1 > /root/apps/brutus/X1
fi

exit 0
