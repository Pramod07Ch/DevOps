#! /bin/bash

# set -e

# validating existing user is a root user or not
ID=$(id -u) # u gives particular userid

COMPONENT=mongodb
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

# comands start #

if [ "$ID" -ne 0 ] ; then 
    echo -e "\e[31m You should execute the script as a root user or sudo as a prefix \e[0m"
    exit 1  
fi


echo -n "configuring $COMPONENT repo:"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
check_status $?

echo -n "Installing $COMPONENT:"
yum install -y mongodb-org &>> $LOG_FILE

check_status $?

echo -n "Starting $COMPONENT:"
systemctl enable mongod &>> $LOG_FILE
systemctl start mongod  &>> $LOG_FILE

check_status $?
# Update Listen IP address from 127.0.0.1 to 0.0.0.0 in the config file, 
# so that MongoDB can be accessed by other services.
echo -n "Updating $COMPONENT visibility:"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
check_status $?

echo -n "Starting $COMPONENT:"
systemctl daemon-reload &>> $LOG_FILE
systemctl restart mongod &>> $LOG_FILE
check_status $?

echo -n "Downloading $COMPONENT schema:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
check_status $?

echo -n "Extracting $COMPONENT schema:"
cd /tmp
unzip -o $COMPONENT.zip &>> $LOG_FILE # o determunes override the folder if it already exsits
check_status $?

echo -n "Injecting $COMPONENT schema:"
cd $COMPONENT-main
mongo < catalogue.js &>> $LOG_FILE
mongo < users.js &>> $LOG_FILE
check_status $?