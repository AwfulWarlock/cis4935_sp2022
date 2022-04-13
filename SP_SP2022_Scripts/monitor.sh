#!/bin/bash
# Used to monitor CPU and RAM usage
echo "Starting CPU and memory monitor..."

# Wipe old logs	
echo "Checking for existing logs..."
if test -f "$HOME/Desktop/CPU.log"
then
	rm $HOME/Desktop/CPU.log

fi
if test -f "$HOME/Desktop/memory.log"
then
	rm $HOME/Desktop/memory.log
fi
if test -f "$HOME/Desktop/IO.log"
then
	rm $HOME/Desktop/IO.log
fi
if test -f "$HOME/Desktop/SERVER_TCPBuffer.log"
then
	rm $HOME/Desktop/SERVER_TCPBuffer.log
fi
echo "Logs wiped. Starting monitoring..."

# Set headers
echo "      date     time $(free -m | grep total | sed -E 's/^    (.*)/\1/g')" >> $HOME/Desktop/memory.log;
pidstat -I -G nginx | head -n 3 | tail -n 1 >> $HOME/Desktop/CPU.log;
pidstat -d -G nginx | head -n 3 | tail -n 1 >> $HOME/Desktop/IO.log;
count=0;
while true
do
	echo "$(date '+%Y-%m-%d %H:%M:%S') $(free -m | grep Mem: | sed 's/Mem://g')" >> $HOME/Desktop/memory.log;
	pidstat -I -G nginx | tail -n 2 >> $HOME/Desktop/CPU.log;
	#top -n 1 -p 816,817 >> $HOME/Desktop/CPU.log;
	pidstat -d -G nginx | head -n 5 | tail -n 1 >> $HOME/Desktop/IO.log;
	cat /proc/net/sockstat | head -n 2 | tail -n 1 >> $HOME/Desktop/SERVER_TCPBuffer.log;

	count=$((count+1));
	echo " $count  ";
	sleep 1
done
