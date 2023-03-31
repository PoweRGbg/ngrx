#!/bin/bash

# function to increment the version number in a VERSION file
# function to increment the version number in a VERSION file
function increment_version() {
    local version_file="$1"
    local version=$(cat "$version_file")
    local major=$(echo "$version" | cut -d'.' -f1)
    local minor=$(echo "$version" | cut -d'.' -f2)
    local patch=$(echo "$version" | cut -d'.' -f3)
    
    if [[ "$increment_option" == "major" ]]; then
        major=$((major+1))
        minor=0
        patch=0
    elif [[ "$increment_option" == "patch" ]]; then
        patch=$((patch+1))
    else
        # increment the minor version by default
        minor=$((minor+1))
        patch=0
    fi
    
    local new_version="$major.$minor.$patch"
    echo "$new_version" > "$version_file"
}


# ensure that we're on the branch we want to merge changes into
git checkout <your-branch-name>

# fetch the latest changes from the master branch
git fetch origin master

# merge the latest changes from the master branch into our current branch
git merge origin/master

# ask user if they want to delete console.log lines
read -p "Do you want to delete all lines containing console.log? [Y/n] " delete_choice
delete_choice=${delete_choice:-Y}
delete_choice=$(echo "$delete_choice" | tr '[:upper:]' '[:lower:]')

if [[ $delete_choice == "y" ]]; then
    # clear all lines containing console.log in the modified files
    git diff --name-only master..HEAD | xargs sed -i '/console.log/d'
fi


# ask the user which version to increment (default: minor)
read -p "Increment major, minor or patch version? (default: minor) " increment_option
increment_option=${increment_option:-"minor"}

# increment the version number in the VERSION file
increment_version VERSION
