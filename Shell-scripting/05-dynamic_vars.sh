#!/bin/bash 

# expressions are enclosed using paranthesis

TODAYDATE=$(date +%F) # 2023-03-29

echo -e "Welcome to bash training. Today date:\e[32m ${TODAYDATE} \e[0m"
echo -e "No. of sessions opened in the system: \e[32m $(who | wc -l) \e[0m"
