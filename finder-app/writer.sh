#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi

writefile="$1"
writestr="$2"

# Create the directory path if it doesn't exist
writefile_dir=$(dirname "$writefile")
if [ ! -d "$writefile_dir" ]; then
    mkdir -p "$writefile_dir"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create the directory path '$writefile_dir'."
        exit 1
    fi
fi

# Write the content to the file
echo "$writestr" > "$writefile"
if [ $? -ne 0 ]; then
    echo "Error: Failed to write to '$writefile'."
    exit 1
fi

echo "Created file: $writefile"
echo "With content:"
echo "$writestr"
exit 0

