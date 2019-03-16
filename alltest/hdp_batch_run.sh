#!/bin/bash

SERVERS="ip1 ip2 ip3 "
PASSWORD=

# 免密码登陆函数
auto_ssh_copy_id() {
    expect -c "set timeout -1;
        spawn ssh-copy-id $1;
        expect {
            *(yes/no)* {send -- yes\r;exp_continue;}
            *assword:* {send -- $2\r;exp_continue;}
            eof     {exit 0;}
        }";
}

ssh_copy_id_to_all(){
    #rm -f /root/.ssh/authorized_keys
    #auto_ssh_copy_id 172.22.213.82 $PASSWORD
    for SERVER in $SERVERS
        do
            auto_ssh_copy_id $SERVER $PASSWORD
            #echo $SERVER
        done
}

#rm -f /root/.ssh/authorized_keys
#./hdp_ssh_init.sh

#ssh_copy_id_to_all

for SERVER in $SERVERS
    do
        
        #ssh root@$SERVER "source /etc/profile;mkdir /root/lampard"
        #scp /root/lampard/key.exp root@$SERVER:/root/lampard
        
        scp /root/lampard/userlist root@$SERVER:/root/lampard
        
        scp /root/soft_pkg/* root@$SERVER:/software/servers
        #scp /root/lampard/delpsanduser.sh root@$SERVER:/root/lampard
        #ssh root@$SERVER /root/lampard/delpsanduser.sh
        
        
        #to tar all the files in the dir-software/servers  --yuzhaoxi 20190211 
        #ssh root@$SERVER 'cd /software/servers && ls /software/servers/*.tar.gz | xargs -n1 tar xzvf' 
      
        #scp /root/lampard/send.exp root@$SERVER:/root/lampard
        #scp /root/lampard/hdp_ssh_init.sh root@$SERVER:/root/lampard
        #ssh root@$SERVER /root/lampard/hdp_ssh_init.sh
        #ssh root@$SERVER "source /etc/profile;rm -Rf /root/lampard"
    done

echo "allwork done"
#for SERVER in $SERVERS
#    do
#        scp /root/.ssh/authorized_keys root@$SERVER:/root/.ssh
#    done

