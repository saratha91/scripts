#!/usr/bin/ruby

# Install Redis server and then start/stop and take backup.
#only allow root user to execute the script.

if Process::euid==0
  print "Allowed to execute.\n"
else
  print "Access denied. Execute as Sudoer.\n"
end

#Defining functions 
def get_server_install()
  print "enter the option {yes} OR {no} to install Redis server:"
  install = $stdin.gets.chomp
  case install
  when "yes"
    output1 = `sudo apt install redis`
    output2 = `redis-server --version | awk '{print $1 $2 $3}'`.strip
    print ("Redis server is installed and #{output2} \n" )
  when "no"
    print "Redis server is not installed.... \n"
  else
    print "invalid input \n"
  end 
end

def get_server_start()
  print "enter the option 'yes' to install Redis server:"
  start = $stdin.gets
  if start == "yes"
    output1 = `sudo systemctl start redis`
    output2 = `sudo systemctl status redis`
    print "Redis server is started... \n"
    print "#{output2.strip} \n"
  else
    print "invalid input \n"  
  end
end  

def get_server_stop()
   print "enter the option 'yes' to stop Redis server:"
  stop = $stdin.gets
  if stop == "yes"
    output1 = `sudo systemctl stop redis`
    output2 = `sudo systemctl status redis`
    print "Redis server is stopped... \n"
    print "#{output2.strip} \n"
  else
    print "invalid input \n"  
  end
end

def get_server_backup()
   print "enter the option 'yes' to backup Redis server:"
   backup = $stdin.gets
  if backup == "yes"
    status = `systemctl is-active redis`.strip
    print "Redis server status #{status} \n"
    if status == "active"
      output1 =`redis-cli BGSAVE`
      print "Redis server is ACTIVE and #{output1.strip} \n"
    else
      print "Redis server is NOT ACTIVE..\n"
      print "backup operation is failed.... \n"  
    end
  else
    print "invalid input \n"  
  end
end

#calling functions

case ARGV[0]
when "install"
  get_server_install()
when "start"
  get_server_start()
when "stop"
  get_server_stop()
when "backup"
  get_server_backup()
else
  print "Help: ./system-metric.rb {install|start|stop|backup}\n"
end 