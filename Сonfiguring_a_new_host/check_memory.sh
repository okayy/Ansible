#!/bin/bash

if [ "$1" = "-w" ] && [ "$2" -gt "0" ] && [ "$3" = "-c" ] && [ "$4" -gt "0" ]; then

memTotal_b=$(free -b | grep Mem | awk '{print $2}')
memFree_b=$(free -b | grep Mem | awk '{print $4}')
#memShared_b=$(free -b | grep Mem | awk '{print $5}')
memBufCache_b=$(free -b | grep Mem | awk '{print $6}')

memTotal_m=$(free -m | grep Mem | awk '{print $2}')
memFree_m=$(free -m | grep Mem | awk '{print $4}')
#memShared_m=$(free -m | grep Mem | awk '{print $5}')
memBufCache_m=$(free -m | grep Mem | awk '{print $6}')

#memUsed_b=$(($memTotal_b-$memFree_b-$memShared_b-$memBufCache_b))
memUsed_b=$(($memTotal_b-$memFree_b-$memBufCache_b))

#memUsed_m=$(($memTotal_m-$memFree_m-$memShared_m-$memBufCache_m))
memUsed_m=$(($memTotal_m-$memFree_m-$memBufCache_m))

memUsedPrc=$((($memUsed_b*100)/$memTotal_b))

tag=' Memory : '$memUsedPrc%' | Used '$memUsed_m' MB | Total '$memTotal_m' MB'

if [ "$memUsedPrc" -ge "$4" ]; then
echo -e "CRITICAL$tag"
$(exit 2)
elif [ "$memUsedPrc" -ge "$2" ]; then
echo -e "WARNING$tag"
$(exit 1)
else
echo -e "OK$tag"
$(exit 0)
fi

else
echo "Please use this scheme: check_mem.sh -w -c"
exit
fi
