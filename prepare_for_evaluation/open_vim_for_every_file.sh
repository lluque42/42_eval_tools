#!/bin/bash

# Check if exactly one argument is given
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_name>"
    exit 1
fi

DIR="$1"

# Check if the given argument is a directory
if [ ! -d "$DIR" ]; then
    echo "Provided argument is not a directory: $DIR"
    exit 1
fi

# Open the first file in a new maximized terminal window
first_file=true

# Iterate over each file in the directory
for file in "$DIR"/*
do
    if [ -f "$file" ]
	then
		gnome-terminal --tab -- bash -c "vim '$file'; exec bash"
	fi
done

echo "All files have been opened in vim, the first in a new maximized terminal window and the rest in new tabs."

