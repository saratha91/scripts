#!/bin/bash

# Install Redis server and then start/stop and take backup.


#only allow root user to execute the script.
if [ `whoami` == 'root' ]; then
  printf "Allowed to execute.\n"
else
  printf "Access denied. Execute as Sudoer.\n"
fi

#Defining functions 
function get_server_install(){
  printf "Install Redis server...\n"
#Download Redis server.
  sudo apt install redis;
  redis-server --version | awk '{print $1 $2 $3}';
  printf "Redis server is installed.... \n"
}

function get_server_start(){
  printf "start Redis server...\n"
  sudo systemctl start redis.service;
  sudo systemctl status redis.service;
}

function get_server_stop(){
  printf "stop Redis server...\n" 
  sudo systemctl stop redis.service;
  sudo systemctl status redis.service;
}

function get_server_backup(){
  printf "backup Redis server...\n" 
  sudo cp /home/vagrant/dump.rdb /home/vagrant/test.txt;
  echo = $(cat test.txt);
}

#calling functions
case $1 in
  install )
   get_server_install
    ;;
  start )
   get_server_start
    ;;
  stop )
   get_server_stop 
    ;;
  backup)
   get_server_backup
    ;;   
  *)
   printf "Help: ./redis-database.sh {Install|start|stop|backup}\n"
    ;; 
esac