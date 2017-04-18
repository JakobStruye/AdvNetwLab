#!/bin/bash

crontab -l > cron
echo "0,10,20,30,40,50 * * * * /root/run_scan24.sh
5,15,25,35,45,55 * * * * /root/run_scan50.sh
1 0 * * * /root/flush_files.sh" >> cron
crontab cron
rm cron

mkdir -p /root/output

