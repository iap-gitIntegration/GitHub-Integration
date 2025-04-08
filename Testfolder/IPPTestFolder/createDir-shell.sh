#!/bin/bash

# Check if exactly two arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <path> <directory_name>"
  exit 1
fi

# Assign the arguments to variables
target_path="$1"
directory_name="$2"
full_path="${target_path}/${directory_name}"

# Check if the target path exists and is a directory
if [ ! -d "$target_path" ]; then
  echo "Error: Path '$target_path' does not exist or is not a directory."
  exit 1
fi

# Check if the directory already exists at the specified path
if [ -d "$full_path" ]; then
  echo "Directory '$full_path' already exists."
else
  # Create the directory at the specified path
  mkdir "$full_path"
  if [ $? -eq 0 ]; then
    echo "Directory '$directory_name' created successfully at '$target_path'."
  else
    echo "Error creating directory '$directory_name' at '$target_path'."
  fi
fi

exit 0
