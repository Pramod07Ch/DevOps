#! /bin/bash

# set -e

# validating existing user is a root user or not
ID=$(id -u) # u gives particular userid

COMPONENT=user
LOG_FILE="/tmp/$COMPONENT.log"
APPSUER=roboshop
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

echo -n "configuring nodejs repo:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOG_FILE
check_status $?

echo -n "Installing nodejs:"
yum install nodejs -y &>> $LOG_FILE
check_status $?

id $APPSUER &>> $LOG_FILE
if [ $? -ne 0 ] ; then
    echo "Creating the aplication user account"
    useradd $APPSUER &>> $LOG_FILE
    check_status $?
fi


echo "Downloading the $COMPONENT component"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
check_status $?

echo "extracting the $COMPONENT in the $APPSUSER diectory"
cd /home/$APPSUER
unzip -o /tmp/$COMPONENT.zip &>> $LOG_FILE
check_status $?

echo -n "config the permisssions"
rm -rf /home/$APPSUER/$COMPONENT &>> $LOG_FILE
mv /home/$APPSUER/$COMPONENT-main /home/$APPSUER/$COMPONENT
chown -R $APPSUER /home/$APPSUER/$COMPONENT
check_status $?

echo -n "Installing the application"
cd /home/$APPSUER/$COMPONENT
npm install &>> $LOG_FILE
check_status $?

echo -n "upadting the sxstemd file with DB details:"
sed -i -e 's/REDIS_ENDPOINT/172.31.94.225/' -e 's/MONGO_ENDPOINT/172.31.91.124' /home/$APPSUER/$COMPONENT/systemd.service
mv /home/roboshop/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
check_status $?

echo -n "restarting $COMPONENT:"
systemctl daemonreload &>> $LOG_FILE
systemctl enable $COMPONENT &>> $LOG_FILE
systemctl start $COMPONENT &>> $LOG_FILE
check_status $?



