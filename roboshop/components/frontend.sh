#! /bin/bash

set -e

# validating existing user is a root user or not
ID=$(id -u) # u gives particular userid

if [ "$ID" -ne 0 ] ; then 
    echo -e "\e[31m You should execute the script as a root user or sudo as a prefix \e[0m"
    exit 1  
fi

echo -n "Installing nginx:"
yum install nginx -y &>> /tmp/frontend.log

if [ $? -eq 0 ] ; then
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"

fi


curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf * &>> /tmp/frontend.log
unzip /tmp/frontend. &>> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md 
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl enable nginx &>> /tmp/frontend.log
systemctl start nginx &>> /tmp/frontend.log