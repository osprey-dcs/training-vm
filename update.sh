#!/bin/bash
# update.sh

# abort script on any errors
set -e

# Update script that tries to pull the training VM to the appropriate latest versions

# Improved robustness:
# - tries the first command line arg or "." as location for the collection
# - remaining command line args are passed through to ansible-playbook call

# - runs 'git pull --recurse-submodules' on the collection
# - runs ansible

collection_dir=${1%/}

if [[ "$(whoami)" == "root" ]]; then
  echo "This script must be run by a regular user (with sudo privileges)."
  exit 1
fi

if [ -d "${collection_dir}" ]; then
    shift
elif [ -d "./vm-setup/ansible" ]; then
    collection_dir="."
fi

bootstrap_dir=${collection_dir}/vm-setup

if [ ! -d ${bootstrap_dir}/ansible ]; then
    echo "update.sh [collection_dir] [ansible-playbook args...]"
    exit 1
fi

if [ -e "/etc/epics-training" ]; then
    slug=$(</etc/epics-training)
else
    slug=""
fi

# Stash any user changes prior to doing the updates, then restore them prior to running the update.
# Handles empty stash if no existing changes
pushd ${collection_dir}
stashed=$(git stash create 'update.sh saving')
[ -z "$stashed" ] || git reset --hard
git checkout --recurse-submodules ${slug}
git pull --recurse-submodules
[ -z "$stashed" ] || git stash apply "$stashed"
popd

if [ ! -e "${collection_dir}/vm-setup/ansible/vars/local.yml" ]; then
    ln -s "../../../local.yml" "${collection_dir}/vm-setup/ansible/vars/local.yml"
fi

cd ${bootstrap_dir}/ansible
ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml "$@" -e "@vars/local.yml"
