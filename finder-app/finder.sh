#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <filesdir> <searchstr>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

# Check if filesdir is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: '$filesdir' is not a directory."
    exit 1
fi

# Function to count matching lines in a file
count_matching_lines() {
    local file="$1"
    local searchstr="$2"
    local count=0

    while IFS= read -r line; do
        if [[ "$line" =~ $searchstr ]]; then
            ((count++))
        fi
    done < "$file"

    echo "$count"
}

# Initialize counters
file_count=0
matching_lines_count=0

# Recursively search for files in the directory
while IFS= read -r -d '' file; do
    if [ -f "$file" ]; then
        ((file_count++))
        lines_count=$(count_matching_lines "$file" "$searchstr")
        ((matching_lines_count += lines_count))
    fi
done < <(find "$filesdir" -type f -print0)

# Print the results
echo "The number of files are $file_count and the number of matching lines are $matching_lines_count"

# Exit with success status
exit 0

