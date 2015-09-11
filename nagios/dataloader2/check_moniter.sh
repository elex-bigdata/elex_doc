#!/bin/bash

#working dir
PATH=/sbin:/bin:/usr/sbin:/usr/bin
time=`date +%Y-%m-%d,%H:%M:%S`

workDir=/home/hadoop/xa
logDir=${workDir}/log
runJar=${workDir}/runJar

jar="dataloader_test.jar";

hadoopsh="/usr/lib/hadoop/bin/hadoop"


#***************
#run the dataloader

main1="com.xingcloud.dataloader.server.DataLoaderETLWatcher" 
main2="com.xingcloud.dataloader.server.DataLoaderFlushWatcher"
private_ip=`/sbin/ifconfig | grep 'inet addr:'| cut -d: -f2 | awk '{ print $1}'|egrep "^10.|^192.|^172." | head -1`

pid1=`ps aux|grep $main1|awk '{print $2}'`
pid2=`ps aux|grep $main2|awk '{print $2}'`

if [ "$pid1" == "" ];then
        errornode1="${errornode1}  $private_ip"
fi  
if [ "$errornode1" == "" ];then
    echo "DataLoader_ETL is OK"
    exit 0
else
    echo ${errornode1} dataloader_etl stopped
    exit 2
fi

if [ "$pid2" == "" ];then
        errornode2="${errornode2}  $private_ip"
fi  
if [ "$errornode2" == "" ];then
    echo "DataLoader_flush is OK"
    exit 0
else
    echo ${errornode2} dataloader_flush stopped
    exit 2
fi
