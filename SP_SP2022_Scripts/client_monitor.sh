#!/bin/bash

echo "Starting CLIENT monitoring..."

# Wipe existing logs
if test -f "$HOME/Desktop/CLIENT_TCPBuffer.log"
then
	rm $HOME/Desktop/CLIENT_TCPBuffer.log
fi

count=0;
while true
do
	cat /proc/net/sockstat | head -n 2 | tail -n 1 >> $HOME/Desktop/CLIENT_TCPBuffer.log;
	count=$((count+1));
	echo " $count ";
	sleep 1
done
