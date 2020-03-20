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

# Display name of script running if an argument is given
if [[ -n ${DEBUG} ]]; then
	# Announcing what script is running
	printf "Executing script %s\n" "${0}"
fi

# Update apt
task_message "Update apt cache"
apt update -y 2> /dev/null
echo

# Download docker-ce install dependencies
task_message "Download docker-ce dependencies first"
apt install apt-transport-https \
            ca-certificates \
            curl \
            software-properties-common	\
	    -y 2> /dev/null
echo

# Add docker's GPG key
task_message "Add docker's GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
echo


# Install the docker repository
task_message "Install docker repository"
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo

# Update repository with new docker repo
task_message "Update apt to apply new docker repo"
apt update -y 2> /dev/null
echo

# Install latest version of docker
task_message "Install latest docker version"
apt install docker-ce
echo

# Display name of script that was running if an argument is given
if [[ -n ${DEBUG} ]]; then
	# Output the ending of this script
	printf "Concluding the run of script %s\n" "${0}"
fi
