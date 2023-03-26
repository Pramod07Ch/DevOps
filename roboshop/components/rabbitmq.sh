#! /bin/bash

# set -e

COMPONENT=rabbitmq

source components/common.sh # source loads the file

echo -n "Installing and configuring dependency:"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash   &>> $LOG_FILE 
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash  &>> $LOG_FILE 
check_status $?

echo -n "Installing server:"
yum install rabbitmq-server -y   &>> $LOG_FILE
check_status $?

echo -n "Starting $COMPONENT :"
systemctl enable rabbitmq-server  &>> $LOGFILE 
systemctl start rabbitmq-server   &>> $LOGFILE 
check_status $?



rabbitmqctl list_users | grep $APPSUSER  &>> $LOG_FILE 
if [ $? -ne 0 ] ; then
    echo -n "creating $COMPONENT applicaton user"
    rabbitmqctl add_user roboshop roboshop123   &>> $LOG_FILE 
    check_status $?

fi

echo -n "Adding required privileges to the $APPUSER :"
    rabbitmqctl set_user_tags roboshop administrator           &>> $LOG_FILE 
    rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"   &>> $LOG_FILE 
    check_status $?