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

CURRENT_VERSION="2.30.0"
# Fetch tar archive for saml2aws
task_message "Fetch saml2aws ${CURRENT_VERSION}"
curl -L https://github.com/Versent/saml2aws/releases/download/v${CURRENT_VERSION}/saml2aws_${CURRENT_VERSION}_linux_amd64.tar.gz  -o saml2aws.tar.gz
echo

# Untar saml2aws
ntask_message "Install saml2aws"
tar xzvf saml2aws.tar.gz -C ~/.local/bin saml2aws
echo

# Clean working directory
task_message "Clean working directory"
rm saml2aws.tar.gz 2> /dev/null
popd
echo

if [[ -n ${DEBUG} ]]; then
	# Output the ending of this script
	printf "Concluding the run of script %s\n" "${0}"
fi
