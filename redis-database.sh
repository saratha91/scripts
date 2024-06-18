#!/bin/bash

# Install Redis server and then start,stop and take backup.


#only allow root user to execute the script.
if [ `whoami` == 'root' ]; then
  printf "Allowed to execute.\n"
else
  printf "Access denied. Execute as Sudoer.\n"
fi

#Defining functions 
function get_server_install(){
  read -p "enter the option 'yes' OR 'no' to install Redis server:" option;
  if [ $option == 'yes' ]; then
    sudo apt install redis;
    redis-server --version | awk '{print $1 $2 $3}';
    printf "Redis server is installed... \n"
  elif [ $option == 'no' ]; then
    printf "Redis server is not installed.... \n"
  else
    printf "Invalid input. \n"
  fi
}  


function get_server_start(){
  read -p "enter the option 'yes' to start Redis server:" option;
  if [ $option == 'yes' ]; then
    sudo systemctl start redis;
    printf "starting  Redis server...\n"
    sudo systemctl status redis;
  else
    printf "Invalid input. \n"
  fi
}

function get_server_stop(){
  read -p "enter the option 'yes' to stop Redis server:" option;
  if [ $option == 'yes' ]; then
    sudo systemctl stop redis;
    printf "stoping Redis server...\n"
    sudo systemctl status redis;
  else
    printf "Invalid input. \n"
  fi

}

function get_server_backup(){
  read -p "enter the option 'yes' to get backup of Redis server:" option;
  if [ $option == 'yes' ]; then
    STATUS=$(systemctl is-active redis.service);
    if [ ${STATUS} = "active" ]; then
      printf "Redis server is ACTIVE..\n"
      printf "Redis server started to backup ...\n" 
      redis-cli BGSAVE;
    else
      printf "Redis server is NOT ACTIVE..\n"
      printf "backup operation is failed.... \n"
    fi
  else
    printf "Invalid input. \n"
    
  fi
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
   printf "Help: ./redis-database.sh {install|start|stop|backup}\n"
    ;; 
esac
