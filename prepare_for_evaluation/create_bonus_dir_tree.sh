#!/bin/bash

# Check if exactly two arguments are given
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

SRC_DIR="$1"
DST_DIR="$2"

# Check if source directory exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Source directory does not exist: $SRC_DIR"
    exit 1
fi

# Create destination directory if it doesn't exist
mkdir -p "$DST_DIR"

# Copy directory structure and files
rsync -a --include '*/' --include '*' --exclude '*' "$SRC_DIR/" "$DST_DIR/"

# Function to rename files in the destination directory
rename_files() {
    local dir="$1"
    for file in "$dir"/*
	do
		if [ -f "$file" ]
		then
			local filename=$(basename -- "$file")
			local extension="${filename##*.}"
			local name="${filename%.*}"
			local new_name="${name}_bonus.${extension}"
			mv "$file" "$dir/$new_name"
		elif [ -d "$file" ]; then
			rename_files "$file"
		fi
    done
}

# Start renaming files from the destination directory root
rename_files "$DST_DIR"

echo "Replication and renaming completed successfully."
