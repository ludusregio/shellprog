#!/usr/bin/env bash

DEBUG=${1:-""}

# A brief message anouncing the task being performed
task_message() {
    printf "[TASK %d] %s\n" $((++task)) "${1}"
}

if [[ -n ${DEBUG} ]]; then
	# Announcing what script is running
	printf "Executing script %s\n" "${0}"
fi

VER="2.2.7"
URI="https://releases.hashicorp.com/vagrant/${VER}/vagrant_${VER}_x86_64.deb"

# Make a temporary directory to download the vagrant package
WDIR="/tmp/vagrant-v${VER}"
task_message "create ${WDIR}"
if [[ -d ${WDIR} ]]; then
	rm -rf "${WDIR}"
fi
mkdir -p "${WDIR}" && pushd "${WDIR}" > /dev/null 2>&1
echo

# Download vagrant
task_message "download vagrant ${VER} package"
curl -sSL "${URI}" -o "vagrant.deb"
popd
echo

if [[ -n ${DEBUG} ]]; then
	# Output the ending of this script
	printf "Concluding the run of script %s\n" "${0}"
fi
