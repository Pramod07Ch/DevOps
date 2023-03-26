#! /bin/bash

# set -e

# validating existing user is a root user or not
ID=$(id -u) # u gives particular userid

COMPONENT=frontend
LOG_FILE = "/tmp/$COMPONENT.log"

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

echo -n "Installing nginx:"
yum install nginx -y &>> $LOG_FILE

check_status $?

echo -n "Downloading $COMPONENT:"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

check_status $?

echo -n "Performaing cleanup of old $COMPONENT content:"
cd /usr/share/nginx/html
rm -rf * &>> $LOG_FILE

unzip /tmp/$COMPONENT.zip &>> $LOG_FILE
mv frontend-main/* .
mv static/* .
rm -rf $COMPONENT-main README.md 
mv localhost.conf /etc/nginx/default.d/roboshop.conf

check_status $?

echo -n "Starting the service:"
systemctl enable nginx &>> $LOG_FILE
systemctl start nginx &>> $LOG_FILE

check_status $?