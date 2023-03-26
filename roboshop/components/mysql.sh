#! /bin/bash

# set -e

# validating existing user is a root user or not
ID=$(id -u) # u gives particular userid

COMPONENT=mysql

source components/common.sh

echo -n "Configuring the $COMPONENT repo :"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo 
check_status $?

echo -n "Installing the $COMPONENT :"
yum install mysql-community-server -y  &>> $LOG_FILE  
check_status $? 

echo -n "Starting $COMPONENT :" 
systemctl enable mysqld  &>> $LOG_FILE  
systemctl start mysqld   &>> $LOG_FILE  
check_status $?