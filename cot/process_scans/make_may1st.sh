#!/bin/bash
#2.4Ghz --> type =0
type=0
start=1
end=11
diff=5

#5  Ghz --> type = 1
# type=1
# start=36
# end=64
# diff=4

for i in cot-node3-student cot-node4-student cot-node5-student cot-node6-student cot-node7-student cot-node8-student cot-node9-student cot-node10-student cot-node11-student cot-node12-student ; do
  j=$start
  while [ $j -le $end ]
  do
    python plot_week_smoothings_5min.py ~/Desktop/UA/AdvNetwLab/backup_mosaic_data_10_05_2017/$i/output/ 2017-04-29,2017-04-30,2017-05-01,2017-05-02,2017-05-03 $type 5 $j 2017-04-28 2017-05-04 $i
    j=$[$j+$diff]
  done
done
