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

echo -n "Grab $COMPONENT default pasword:"
DEFAULT_ROOT_PSWR=$(grep "temporary password" /var/log/mysqld.log | awk '{print $NF}')
check_status $?

# This should only run for the first time or when the default password is not changed.
echo "show databases;" | mysql -uroot -pRoboShop@1   &>> $LOG_FILE 
if [ $? -ne 0 ] ; then 

    echo -n "Password Reset of root user :"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PSWR} &>> $LOG_FILE 
    check_status $?

fi 

# Ensure you run this only when the password validate plugin exist 
echo "show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password  &>> $LOG_FILE 
if [ $? -eq 0 ] ; then 

    echo -n "Uninstalling Password Validation Plugin :"
    echo "uninstall plugin validate_password;" | mysql -uroot -pRoboShop@1   &>> $LOG_FILE
    check_status $?

fi 

echo -n "Downloading the $COMPONENT Schema :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"  &>> $LOG_FILE
check_status $? 

echo -n "Extracting the $COMPONENT Schema :"
cd /tmp 
unzip -o /tmp/$COMPONENT.zip &>> $LOG_FILE
check_status $? 

echo -n "Injecting the schema :"
cd $COMPONENT-main
mysql -uroot -pRoboShop@1 < shipping.sql 
check_status $? 



