LOG_FILE="/tmp/$COMPONENT.log"
APPSUER=roboshop

# validating existing user is a root user or not
ID=$(id -u) # u gives particular userid

# functions
check_status() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[31m Failure \e[0m"
        exit 2
    fi
}


CREATE_USER() {
    id $APPSUER &>> $LOG_FILE
    if [ $? -ne 0 ] ; then
        echo "Creating the aplication user account"
        useradd $APPSUER &>> $LOG_FILE
        check_status $?
    fi

}

DOWNLOAD_EXTRACT() {
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
}

CONFIG_SERVICE() {
    echo -n "upadting the sxstemd file with DB details:"
    sed -i -e 's/DBHOST/172.31.60.187/' -e 's/CARTENDPOINT /172.31.86.210/' -e 's/MONGO_DNSNAME/172.31.91.124/' -e 's/REDIS_ENDPOINT/172.31.94.225/' -e 's/MONGO_ENDPOINT/172.31.91.124/' /home/$APPSUER/$COMPONENT/systemd.service
    mv /home/roboshop/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
    check_status $?

    echo -n "restarting $COMPONENT:"
    systemctl daemonreload &>> $LOG_FILE
    systemctl enable $COMPONENT &>> $LOG_FILE
    systemctl start $COMPONENT &>> $LOG_FILE
    check_status $?


}

NPM_INSTALL() {
    echo -n "Installing the application"
    cd /home/$APPSUER/$COMPONENT
    npm install &>> $LOG_FILE
    check_status $?
}

MVN_PACKAGE() {
    echo -n "Creating the $COMPONENT Package :"
    cd /home/$APPUSER/$COMPONENT/ 
    mvn clean package  &>> $LOG_FILE
    mv target/shipping-1.0.jar shipping.jar
    check_status $?   
}



JAVA() {
    echo -n "Installing Maven"
    npm install maven -y &>> $LOG_FILE
    check_status $?

    # calling function user
    CREATE_USER

    # download and extract
    DOWNLOAD_EXTRACT

    # run maven package
    MVN_PACKAGE

    # config the service
    CONFIG_SERVICE
}

PYTHON() {

    echo -n "Installing Python and dependencies :"
    yum install python36 gcc python3-devel -y  &>> $LOG_FILE
    check_status $?

    # Calling Create-User Functon 
    CREATE_USER

    # Calling Download_And_Extract Function
    DOWNLOAD_EXTRACT

    echo -n "Installing $COMPONENT :"
    cd /home/roboshop/$COMPONENT/ 
    pip3 install -r requirements.txt   &>> $LOG_FILE 
    check_status $? 

    USERID=$(id -u roboshop)
    GROUPID=$(id -g roboshop)
    
    echo -n "Updating the $COMPONENT.ini file :"
    sed -i -e "/^uid/ c uid=${USERID}" -e "/^gid/ c gid=${GROUPID}"  /home/$APPUSER/$COMPONENT/$COMPONENT.ini 

    # Calling Config-Svc Function
    CONFIG_SVC 
}


NODEJS() {

    echo -n "configuring nodejs repo:"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOG_FILE
    check_status $?

    echo -n "Installing nodejs:"
    yum install nodejs -y &>> $LOG_FILE
    check_status $?

    # calling function user
    CREATE_USER

    # download and extract
    DOWNLOAD_EXTRACT

    # npm install
    NPM_INSTALL

    CONFIG_SERVICE
}







