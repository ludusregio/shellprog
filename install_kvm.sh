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

# Install kvm and dependencies
task_message "Install kvm and dependencies"
apt install -y qemu qemu-kvm libvirt-bin bridge-utils
echo

# Install virt-manager
task_message "Install virt-manager"
apt install -y virt-manager
echo

if [[ -n ${DEBUG} ]]; then
	# Output the ending of this script
	printf "Concluding the run of script %s\n" "${0}"
fi
