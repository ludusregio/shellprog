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

# Install git
task_message "Install Multiple packages"
apt-get -qq -o Dpkg::Use-Pty=0 \
            -o Dpkg::Progress-Fancy=0 \
	    --no-install-recommends install -y  \
	    git \
	    openvpn \
	    unzip \
	    tar \
	    make \
	    dirmngr \
	    netcat \
	    ruby \
	    ruby-bundler \
	    python \
	    python-pip \
	    python-openssl \
	    libusb
echo

# Gem update
task_message "Gem update"
gem update --no-document --system 3.0.6
echo

# Install thor
task_message "Install thor"
gem install --no-document thor
echo

# Install python modules using pip2
#task_message "Install pip packages needed for devops ansible"

if [[ -n ${DEBUG} ]]; then
	# Output the ending of this script
	printf "Concluding the run of script %s\n" "${0}"
fi
