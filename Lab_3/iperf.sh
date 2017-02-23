#!/bin/bash
for i in seq 2 4 6 8 10 12 14 16 18 20; do
    echo $1
    iw dev wlan0 set bitrates legacy-5 i
    iperf -V -c $1
done
