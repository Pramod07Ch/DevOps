#! /bin/bash

# set -e

# validating existing user is a root user or not
ID=$(id -u) # u gives particular userid

COMPONENT=redis
LOG_FILE="/tmp/$COMPONENT.log"

# functions
check_status() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[31m Failure \e[0m"
        exit 2
    fi
}

if [ "$ID" -ne 0 ] ; then 
    echo -e "\e[31m You should execute the script as a root user or sudo as a prefix \e[0m"
    exit 1  
fi

echo -n "configuring $COMPONENT repo:"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>> $LOG_FILE
check_status $?

echo -n "Installing $COMPONENT server :"
yum install redis-6.2.11 -y  &>> $LOG_FILE
check_status $? 

echo -n "Updating $COMPONENT visibility:"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
check_status $?

echo -n "Starting $COMPONENT:"
systemctl daemon-reload &>> $LOG_FILE
systemctl enable $COMPONENT &>> $LOG_FILE
systemctl restart $COMPONENT &>> $LOG_FILE
check_status $?