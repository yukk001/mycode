#!/bin/bash

userlist=$(cut -d ":" -f2  /root/lampard/userlist)

local_host="`hostname --fqdn`"
local_ip=`host $local_host 2>/dev/null | awk '{print $NF}'`

for myuser in  $userlist
do 
#kill the ps 
    pkill -u $myuser
    echo  $local_ip had killed the process user:$myuser




#add the user
    useradd -r $user
    echo  $local_ip had added the  user:$user

#add the group 
    groupad $user
    echo $local_ip had added the group 

done


    mv /software/servers/* /tmp

    #use the new profile
    source /etc/profile








