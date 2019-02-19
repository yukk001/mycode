#!/bin/bash
#Defining variable
#producer: Jing
#mailbox: lijunqiang1@jd.com
#If you want to use  Please modify file path ,use,pw and IP address
prefix_ip=172.22.213.82
user=root
pw=b797d49bfd67f4968d8c4f097c87b33b
keyfile=/root/lampard/key.exp
sendfile=/root/lampard/send.exp
#
yum install expect -y
#Create a key,Execute script to realize key distribution
/usr/bin/expect $keyfile
state=$?
if [[ $state -eq 0 ]];then
    /usr/bin/expect $sendfile $prefix_ip $user $pw
else
    echo "key send is error"
fi

