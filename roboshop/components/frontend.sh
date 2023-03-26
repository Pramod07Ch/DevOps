#! /bin/bash

set -e

COMPONENT=$1
# validating existing user is a root user or not
id=$(id -u)

if ["$ID" -ne 0]; then
    echo -e "\e[31m You should execute the script as a root user or sudo as a prefix \e[0m"
    exit 1  
fi

yum install nginx -y &>> /tmp/{$COMPONENT}.log

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf * &>> /tmp/{$COMPONENT}.log
unzip /tmp/frontend. &>> /tmp/{$COMPONENT}.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md 
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl enable nginx &>> /tmp/{$COMPONENT}.log
systemctl start nginx &>> /tmp/{$COMPONENT}.log