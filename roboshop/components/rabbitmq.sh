#! /bin/bash

# set -e

# validating existing user is a root user or not
ID=$(id -u) # u gives particular userid

COMPONENT=rabbitmqq

source components/common.sh # source loads the file

echo -n "Installing and configuring dependency:"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>> $LOGFILE 
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash  &>> $LOGFILE 
check_status $?

echo -n "Installing server:"
yum install rabbitmq-server -y &>> $LOG_FILE
check_status $?

echo -n "Starting $COMPONENT :"
systemctl enable rabbitmq-server  &>> $LOGFILE 
systemctl start rabbitmq-server   &>> $LOGFILE 
check_status $?



rabbitmqctl list_users | grep $APPSUSER  &>> $LOGFILE 
if [ $? -ne 0 ] ; then
    echo -n "creating $COMPONENT applicaton user"
    rabbitmqctl add_user roboshop roboshop123   &>> $LOGFILE 
    check_status $?

fi

echo -n "Adding required privileges to the $APPUSER :"
    rabbitmqctl set_user_tags roboshop administrator           &>> $LOGFILE 
    rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"   &>> $LOGFILE 
    check_status $?