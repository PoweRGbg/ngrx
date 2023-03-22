#!/bin/bash

# define the error handling function
function handle_error {
  echo "An error occurred!"
  exit 1
}

# define the exit handling function
function handle_exit {
  if [ $? -eq 130 ]; then
    echo "User stopped the script"
  else
    echo "Script completed successfully"
  fi
}

# set the error handling function to run on any non-zero exit code
trap handle_error ERR

# set the exit handling function to run on any exit
trap handle_exit EXIT

# run your Python script here
python your_script.py
