#!/bin/bash

# Shell script to update the training collection repositories
# without executing any of the update activities.
#
# Usage:
# $ path/to/update_repos.sh path/to/training/collection
# OR
# $ cd path/to/training/collection; ./update_repos.sh
#
# e.g.,
# $ cd ~/training/vm-setup; ./update_repos.sh ..
# OR
# $ cd ~/training; ./vm-setup/update_repos.sh

set -e

collection_dir=${1%/}

if [ -d "./vm-setup/ansible" ]; then
    collection_dir="."
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

