#!/bin/bash


#to change the file permisson

awk -F ":" '{ if($2!=0){system("echo chown -R  " $2":"$3 " /software/servers/"$1 "   ")}}' permission_config
awk -F ":" '{system("echo chmod -R  " $4 " /software/servers/"$1 "   ")}' permission_config


#add the path to profile

cat path_config >> /etc/profile

source /etc/profile

