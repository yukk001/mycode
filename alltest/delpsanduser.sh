#!/bin/bash

#del all running process 


userlist=$(cut -d ":" -f2  /root/lampard/userlist)

local_host="`hostname --fqdn`"
local_ip=`host $local_host 2>/dev/null | awk '{print $NF}'`

for myuser in  $userlist
do 
#kill the ps 
    pkill -u $myuser
    echo  $local_ip had killed the process user:$myuser




#del the user
    userdel -r $user
    echo  $local_ip had deled the  user:$user




#to clean the etcprofile $java_home hive_home path spark_home

done


#backup first before clean
    cp /etc/profile /root/lampard/profilebackup

    sed -n '/JAVA_HOME/p;/HADOOP_HOME/p;/HIVE_HOME/p;/SPARK_HOME/p' /etc/profile
#delete the home in profile 
    sed -i '/JAVA_HOME/d;/HADOOP_HOME/d;/HIVE_HOME/d;/SPARK_HOME/d' /etc/profile

#delete the software 
    mv /software/servers/* /tmp

    #use the new profile
    source /etc/profile

    groupadd hadoop

    for newuser in $userlist
    do 
    useradd -m -g hadoop $newuser
    done

