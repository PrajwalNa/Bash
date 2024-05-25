#!/bin/bash

: '
Dev: Prajwal Nautiyal
Last Update: 23 Nov 2022
A shell script to annoy people on the server
'

touch check man_check

# Defining a new File Descriptor to be used to read from file check
exec 3< check
exec 4< man_check

# Taking Input from the user
read -p "Enter a username: " target
read -p "Enter the number of messages to be sent: " num

# checking if the input is empty
if [ -z "$target" ] || [ -z "$num" ]
then
    echo "Input cannot be Empty!!"
    exit 0
fi

# validating the input with regex
if ! [[ "$target" =~ ^[A-Za-z]{1,}[0F-9]* ]] || ! [[ "$num" =~ ^[0-9]+ ]]
then
    echo "Invalid Input"
    exit 0
fi

# asking for the command which the user wishes to send the man page of
read -p "Enter the man page: " command

# validating user choice of command
man $command 2> mcheck 1> tmp
grep "No manual entry for $command" mcheck -c > man_check

read -u 4 m

if ! [[ $m -eq 0 ]]
then
    echo "Invalid Command"
    exit 0
fi

# looking for the target's status, and storing the value in the file check
who -T | egrep "$target\s+\+" -c > check

# reading output from the command
read -u 3 n
echo "users: $n"

# checking the Target's status
if [[ $n -ge 1 ]]
then
    # Running a while loop to send the annoyances for the number user entered
    for x in $(seq 0 $num)
    do
        man $command | write $target 2>/dev/null
        printf "\rMessages sent: $x"
    done
    printf "\n"
    # if the target is offline or has messages turned off
else
    echo "Target is either not Online, or not taking Messages."
    exit 0
fi
