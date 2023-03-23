#!/bin/bash

# function to increment the version number in a VERSION file
function increment_version() {
    local version_file="$1"
    local version=$(cat "$version_file")
    local major=$(echo "$version" | cut -d'.' -f1)
    local minor=$(echo "$version" | cut -d'.' -f2)
    local patch=$(echo "$version" | cut -d'.' -f3)
    patch=$((patch+1))
    local new_version="$major.$minor.$patch"
    echo "$new_version" > "$version_file"
}

# ensure that we're on the branch we want to merge changes into
git checkout <your-branch-name>

# fetch the latest changes from the master branch
git fetch origin master

# merge the latest changes from the master branch into our current branch
git merge origin/master

# increment the version number in the VERSION file
increment_version VERSION