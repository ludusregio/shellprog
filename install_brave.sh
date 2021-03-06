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


# Install dependencies
task_message "Install brave browser dependencies to download"
apt install -y apt-transport-https \
	    cur \
	    2> /dev/null
echo

# Add brave's gpg
task_message "Add brave's gpg key"
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo

# Add brave's repository
task_message "Add brave's repository to the list"
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" >> /etc/apt/sources.list.d/brave-browser-release.list 2> /dev/null
echo

# Update apt
task_message "Update apt cache"
apt update -y 2> /dev/null
echo

# Install brave
task_message "Install brave-browser"
apt install -y brave-browser
echo

if [[ -n ${DEBUG} ]]; then
	# Output the ending of this script
	printf "Concluding the run of script %s\n" "${0}"
fi
