#!/bin/bash

# Check if the directory argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <target_directory>"
  exit 1
fi

# Get the target directory from the argument
target_dir="$1"

# Check if the target directory exists
if [ ! -d "$target_dir" ]; then
  echo "Error: Directory '$target_dir' does not exist."
  exit 1
fi

# Loop through all files in the target directory ending with "_bonus.c"
for file in "$target_dir"/*_bonus.c; do
  # Check if the file exists (to handle cases with no matches)
  if [[ -e $file ]]; then
    # Extract the base name by removing "_bonus.c" and appending ".c"
    new_name="${file%_bonus.c}.c"
    # Rename the file
    mv "$file" "$new_name"
    echo "Renamed '$file' to '$new_name'"
  fi
done

