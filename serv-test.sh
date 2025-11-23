#!/bin/bash

echo "====CPU_USAGE====="
printf "\n"

idle1=$(cat /proc/stat | grep -E "cpu " | awk '{ print $5}')
sum1=$(cat /proc/stat | grep -E "cpu " | awk '{ sum = $2+$3+$4+$5+$6+$7+$8+$9+$10+$11 ; print sum}')

sleep 1 

idle2=$(cat /proc/stat | grep -E "cpu " | awk '{print $5}')
sum2=$(cat /proc/stat | grep -E "cpu " | awk '{ sum = $2+$3+$4+$5+$6+$7+$8+$9+$10+$11 ; print sum}')

awk -v idle1="$idle1" -v idle2="$idle2" -v sum1="$sum1" -v sum2="$sum2" '
{    idleDiff = idle2 - idle1
    totalDiff = sum2 - sum1
    cpu = 100 * (1 - (idleDiff / totalDiff))
    print "Cpu Usage : " cpu "%"
}
'


printf "\n"
echo "===TOTAL_MEM_USAGE==="
printf "\n"

 free -m | grep Mem: | 
 awk '{ total=$2 ; used=$3 ; free=$4 ;
 pourcentageUsed=(used / total) * 100 ; 
 pourcentageFree=(free / total) * 100;
 print "Mem RAM used: " pourcentageUsed " %" ;
 print "Mem RAM not used: " pourcentageFree " %"}'


printf "\n"
echo "===TOTAL_DISK_USAGE==="
printf "\n"

 df -h | grep "/dev/*" |
 awk '{ total=$2 ; used=$3 ; free=$4 ;
 pourcentageUsed=(used / total) * 100 ; 
 pourcentageFree=(free / total) * 100;
 print "Disk : "$1
 printf "\n"
 print "DISK used: " pourcentageUsed " %" ;
 print "DISK not used: " pourcentageFree " %" ;
 printf "\n" }'


printf "\n"
echo "===TOP_5_CPU_USAGE==="
printf "\n"
ps aux --sort=-%cpu | head -n 6 | tail -n 5

printf "\n"
echo "===TOP_5_MEM_USAGE==="
printf "\n"

ps aux --sort=-%mem | head -n 6 | tail -n 5


