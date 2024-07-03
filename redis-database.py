#!/usr/bin/python3

# Install Redis server and then start/stop and take backup.
#only allow root user to execute the script.

# import module.
import os
import sys
import subprocess

#only allow root user to execute the script.
if os.geteuid()==0:
    print('Allowed to execute.')
else:
    print('access denied.Execute as Sudoer.')

#Defining functions 
def get_server_install():
  print('enter the option {yes} OR {no} to install Redis server:')
  install = input()   
  if install == 'yes':
    output1 = subprocess.run(["sudo","apt","install","redis"],check=True)
    print('Redis server is installed and version is')
    output2 = subprocess.run(["redis-cli","--version"],check=True)
  else:
    print('Redis server not installed and give valid input') 

def get_server_start():
  print('enter the option {yes} to start Redis server:')
  start = input()
  if start == 'yes':
    try:
      subprocess.run(['sudo', 'systemctl', 'start', 'redis-server'], check=True)
      print("Redis server started...")
      subprocess.run(['sudo', 'systemctl', 'status', 'redis-server'], check=True)
    except subprocess.CalledProcessError as e:
      print(f"An error occurred during the installation process: {e}")
      exit(1)
  else:
    print('invalid input')

def get_server_stop():
  print('enter the option {yes} to stop Redis server:')
  stop = input()
  if stop == 'yes':
    try:   
      subprocess.run(['sudo', 'systemctl', 'stop', 'redis-server'], check=True)
      print("Redis server stopped...")
      subprocess.run(['sudo', 'systemctl', 'status', 'redis-server'], check=True)
    except subprocess.CalledProcessError as e:
      print(f"An error occurred during the installation process: {e}")
      exit(1)
  else:
    print('invalid input')

def get_server_backup():
  print('enter the option {yes} to backup Redis server:')
  backup = input()
  if backup == 'yes':
    output = subprocess.run(["sudo","systemctl","is-active","redis"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True,check=True)
    print(f"Redis server status is {output.stdout.strip()} ")
    value = output.stdout.strip()
    if value == 'active':
      output1 = subprocess.run(["redis-cli","BGSAVE"],check=True)
      print("Redis serevr is backed up successfully")
    else:
      print("Redis server is NOT ACTIVE and backup operation is failed")
  else:
    print('invalid input')


#calling functions
if sys.argv[1]=='install':
  get_server_install()
elif sys.argv[1]=='start':
  get_server_start()
elif sys.argv[1]=='stop':
  get_server_stop()
elif sys.argv[1]=='backup':
  get_server_backup()
else:
  print('Help: ./system-metric.rb {install|start|stop|backup}')