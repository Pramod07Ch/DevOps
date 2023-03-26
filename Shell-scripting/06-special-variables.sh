#!/bin/bash 

# Special Characters :  
    # $0 to $9 : indexing from terminal and 0 is filename, 1 starts with arguments
    # $*, $@ : gives used variables
    # $# : gives count of used variables
    # $$ : prints PID of current process
    # $? : print the exit code of the last command

echo "Name of the script is : $0"     # Gives the name of the script you're running  

echo first value is $1
echo second value is $2 
echo third value is $3

echo "Supplied variables supplied: $*"
echo "total no. of variables: $?"

# bash scriptName.sh 100 200 300