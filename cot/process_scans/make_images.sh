#!/bin/bash
#2.4Ghz --> type =0
# type=0
# start=1
# end=11
# diff=5

#5  Ghz --> type = 1
type=1
start=36
end=64
diff=4

for i in cot-node3-student cot-node4-student cot-node7-student cot-node9-student cot-node10-student cot-node12-student ; do
  j=$start
  while [ $j -le $end ]
  do
    python plot_week_smoothings.py ~/Desktop/UA/AdvNetwLab/current_backup/$i/outputFLUSH/ 2017-05-15,2017-05-16,2017-05-17,2017-05-18,2017-05-19,2017-05-20,2017-05-21,2017-05-22 $type 5 $j 2017-05-14 2017-05-23 $i
    j=$[$j+$diff]
  done
done

#For cot-node4-student          : 9999-99-99_99-99
#For cot-node3-student          : 9999-99-99_99-99
#For cot-node7-student          : 9999-99-99_99-99
#For cot-node9-student          : 9999-99-99_99-99
#For cot-node12-student         : 9999-99-99_99-99
#For cot-node10-student         : 2017-05-11_11-52 <- enige die 0 is vanwege reboot dus resultaat is nog ok
i='cot-node6-student'
j=$start
while [ $j -le $end ]
do
  #For cot-node6-student          : 2017-05-22_21-31 <- 12 -> 20 is doable with 11 and 21 to smoothe
  python plot_week_smoothings.py ~/Desktop/UA/AdvNetwLab/current_backup/$i/outputFLUSH/ 2017-05-12,2017-05-13,2017-05-14,2017-05-15,2017-05-16,2017-05-17,2017-05-18,2017-05-19,2017-05-20 $type 5 $j 2017-05-11 2017-05-21 $i
  j=$[$j+$diff]
done
i='node1'
j=$start
while [ $j -le $end ]
do
  # #For node1                      : 2017-05-19_23-00 <- 13 -> 17 is doable with 12 and 18 to smoothe
  python plot_week_smoothings.py ~/Desktop/UA/AdvNetwLab/current_backup/$i/outputFLUSH/ 2017-05-13,2017-05-14,2017-05-15,2017-05-16,2017-05-17 $type 5 $j 2017-05-12 2017-05-18 $i
  j=$[$j+$diff]
done
i='cot-node5-student'
j=$start
while [ $j -le $end ]
do
  # #For cot-node5-student          : 2017-05-18_21-46 <- 12 -> 16 is doable with 11 and 17 to smoothe things out
  python plot_week_smoothings.py ~/Desktop/UA/AdvNetwLab/current_backup/$i/outputFLUSH/ 2017-05-12,2017-05-13,2017-05-14,2017-05-15,2017-05-16 $type 5 $j 2017-05-11 2017-05-17 $i
  j=$[$j+$diff]
done
i='cot-node8-student'
j=$start
while [ $j -le $end ]
do
  python plot_week_smoothings.py ~/Desktop/UA/AdvNetwLab/current_backup/$i/outputFLUSH/ 2017-05-12,2017-05-13,2017-05-14,2017-05-15,2017-05-16 $type 5 $j 2017-05-11 2017-05-17 $i
  # #For cot-node8-student          : 2017-05-18_23-31 <- 12 -> 16 is doable, 18 is rekt
  j=$[$j+$diff]
done

#For cot-node11-student         : 2017-05-10_15-40 <- unusable..;
# python plot_week_smoothings.py ~/Desktop/UA/AdvNetwLab/current_backup/$i/outputFLUSH/ 2017-05-15,2017-05-16,2017-05-17,2017-05-18,2017-05-19,2017-05-20,2017-05-21,2017-05-22 0 5 $j 2017-05-14 2017-05-23 $i

# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find cot-node11-student/outputFLUSH/ -size 0 | wc -l
# 20583
# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find cot-node12-student/outputFLUSH/ -size 0 | wc -l
# 0
# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find cot-node3-student/outputFLUSH/ -size 0 | wc -l
# 0
# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find cot-node4-student/outputFLUSH/ -size 0 | wc -l
# 0
# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find cot-node5-student/outputFLUSH/ -size 0 | wc -l
# 8807
# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find cot-node6-student/outputFLUSH/ -size 0 | wc -l
# 3360
# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find cot-node7-student/outputFLUSH/ -size 0 | wc -l
# 0
# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find cot-node8-student/outputFLUSH/ -size 0 | wc -l
# 8704
# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find cot-node9-student/outputFLUSH/ -size 0 | wc -l
# 0
# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find cot-node10-student/outputFLUSH/ -size 0 | wc -l
# 1
# uauser@thomas-P6661:~/Desktop/UA/AdvNetwLab/current_backup$ find node1/outputFLUSH/ -size 0 | wc -l
# 7569
