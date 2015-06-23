#!/bin/sh
result=`ps -ef | grep node | awk '{print $9}'`
isUp=false;
for i in $result
do
if [ "$i" =  "/node_modules/amid/bin/amid-rest" ]
then isUp=true
fi
done
if [ $isUp = false ];then
echo "amid-rest API has found down at $(date)" >> amid-rest-cheker.log
myIp=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
echo "amid rest API has been found down and has been restarted. If everything went ok this should work: http://$myIp:3000/test/fingerprinting?limit=1" | mail  -s "amid-rest API up?" francisco.lopezsancho@ifpi.org
nohup /usr/bin/node /node_modules/amid/bin/amid-rest &
fi

