#!/bin/bash

: '
Dev: Prajwal Nautiyal
Last Update: 16 Nov 2022
A shell script to annoy people on the server
'

# Defining a new File Descriptor to be used to read from file check
exec 3< check

# Initial Value for counter
x = 1

# Taking Input from the user
read -p "Enter a username: " target
read -p "Enter the number of messages to be sent: " num

# checking if the input is empty
if [ -z $target ] || [ -z $num ]
then
    echo "Input cannot be Empty!!"
    exit 0
fi

# validating the input with regex
if ! [[ "$target" =~ ^[A-Za-z]{1,}[0-9]* ]] || ! [[ "$num" =~ [0-9] ]]
then
    echo "Invalid Input"
    exit 0
fi

# asking for the command which the user wishes to send the man page of
read -p "Enter the man page: " command

# validating user choice
if [[ "man $command" == "No manual entry for $command" ]]
then
    echo "Invalid Command"
    exit 0
fi

# looking for the target's status, and storing the value in the file check
who -T | egrep "$target\s+\+" -c > check

# asking user to input output shown by command
read -u 3 n
echo $n

# checking the Target's status
if [[ $n -ge 1 ]]
then
    # Running a while loop to send the annoyances for the number user entered
    while [[ $x -le num ]]
    do
        man $command | write $target
        echo "Messages sent: $x"
        x=$(( $x + 1 ))
    done
# if the target is offline or has messages turned off
else
    echo "Target is either not Online, or not taking Messages."
    exit 0
fi