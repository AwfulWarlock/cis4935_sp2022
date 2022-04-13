#!/bin/bash
read -p "Press (1) for HTTP3, (2) for HTTP2: " version


if (($version == 1))
then
    echo "You chose HTTP3"
    read -p "Press (1) for curl, (2) for image pull: " choice
    read -p "Num to run in parallel: " num
    if (( $choice == 1)) 
    then
	{ time (xargs -I % -P $num -n 1 curl -ks -o /dev/null --http3  "https://172.31.81.42/" < <(printf '%s\n' {1..$num})) } 2> $HOME/Desktop/runtime.log
    else
	#xargs -I % -P $num -n 1 curl -ks -o /dev/null --http3 "https://172.31.81.42/img/car.jpg" < <(printf '%s\n' {1..$num})
	{ time (seq 1 $num | xargs -n 1 -P $num curl --http3 https://172.31.81.42/img/image.jpg -ks -o /dev/null) } 2> $HOME/Desktop/runtime.log
    fi # Inner IF
else
    echo "You chose HTTP2 ya goober"
    read -p "Press (1) for curl, (2) for image pull: " choice
    read -p "Num to run in parallel: " num
    if (( $choice == 1)) 
    then
	{ time (xargs -I % -P $num -n 1 curl -ks --max-time 5 -o /dev/null --http2  "https://172.31.81.42/" < <(printf '%s\n' {1..$num})) } 2> $HOME/Desktop/runtime.log
    else
	{ time (seq 1 $num | xargs -n 1 -P $num curl --http2 https://172.31.81.42/img/image.jpg --max-time 5 -ks -o /dev/null) } 2> $HOME/Desktop/runtime.log
	#xargs -I % -P $num -n 1 curl -ks --max-time 5 -o /dev/null --http2  "https://172.31.81.42/img/car.jpg" < <(printf '%s\n' {1..$num})
    fi # Inner IF
fi # Outter IF

wait
echo "All $num finished."
