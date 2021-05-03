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

# working directory
pushd /tmp
# Fetch zip archive for awscli
task_message "Fetch awscli"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 2> /dev/null
echo

# Unzip awscli
task_message "Unzip awscli"
unzip awscliv2.zip 2> /dev/null
echo

# Install awscli
task_message "Install awscli"
./aws/install -i ~/.local/aws-cli -b ~/.local/bin 2> /dev/null
echo

# Clean working directory
task_message "Clean working directory"
rm awscliv2.zip 2> /dev/null
rm -rf aws 2> /dev/null
popd
echo

if [[ -n ${DEBUG} ]]; then
	# Output the ending of this script
	printf "Concluding the run of script %s\n" "${0}"
fi
