#!/bin/bash
a=`ifconfig | grep addr: | grep Bcast | awk '{print $2}'| awk -F: '{print $2}'`
while read line
do
hostname=`echo $line |awk '{print $1}'`
ip=`echo $line |awk '{print $2}'`

iplist=($a)

for i in ${iplist[@]}
do
if [ "$i" == "$ip" ];then
 hostname $hostname 
 sed -i s/^HOSTNAME.*$/HOSTNAME=$hostname/g /etc/sysconfig/network
 sed -i -e /^$i/d /etc/hosts
 echo "$ip  $hostname" >> /etc/hosts
# service network restart
# `bash`
# echo $hostname
fi

done

done </tmp/list
