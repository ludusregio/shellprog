#!/usr/bin/env bash

DEBUG=${1:-""}

# A brief message anouncing the task being performed
task_message() {
    printf "[TASK %d] %s\n" $((++task)) "${1}"
}

# Stop if run as root
if [[ $EUID -eq 0 ]]; then
   echo "This script must be run as a normal user" 
   exit 1
fi

if [[ -n ${DEBUG} ]]; then
	# Announcing what script is running
	printf "Executing script %s\n" "${0}"
fi

# Install pipenv in user home
task_message "Install --user pipenv"
python3 -m pip install --user pipenv
echo

if [[ -n ${DEBUG} ]]; then
	# Output the ending of this script
	printf "Concluding the run of script %s\n" "${0}"
fi
