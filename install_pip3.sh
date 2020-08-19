#!/usr/bin/env bash

DEBUG=${1:-""}

# A brief message anouncing the task being performed
task_message() {
    printf "[TASK %d] %s\n" $((++task)) "${1}"
}

# Stop if root is not running this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with elevated privileges" 
   exit 1
fi

if [[ -n ${DEBUG} ]]; then
	# Announcing what script is running
	printf "Executing script %s\n" "${0}"
fi

# Update apt
task_message "Update apt cache"
apt update -y 2> /dev/null
echo

# Install python3
task_message "Install python3"
apt install -y python3
echo

# Install pip3
task_message "Install pip3"
apt install -y python3-pip
echo

if [[ -n ${DEBUG} ]]; then
	# Output the ending of this script
	printf "Concluding the run of script %s\n" "${0}"
fi
