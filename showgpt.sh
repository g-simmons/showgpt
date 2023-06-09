#!/bin/bash

# Check if the current directory is part of a git repo
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  # If it is, generate a list of files excluding gitignored files
  source_list=($(git ls-files --exclude-standard))
else
  # Otherwise, generate a list of all files in the current directory and its subdirectories
  source_list=($(find . -type f))
fi

# Accept additional list of files or glob strings as arguments, if any
if [ "$#" -gt 0 ]; then
  source_list=("$@")
fi

# Check if the script was called with -h or --help
if [[ $1 == "-h" || $1 == "--help" ]]; then
  # Display the usage statement and exit
  echo
  echo "Usage: showgpt [file1] [file2] ..."
  echo "Displays the contents of specified files or all files within the current directory (and its subfolders), excluding gitignored files if the current directory is part of a git repo."
  echo
  echo "Options:"
  echo "-h, --help     Displays this usage statement."
  echo

  exit 0
fi

# Check if there is a readme file in the source list (case-insensitive)
readme_index=-1
for i in "${!source_list[@]}"
do
  if echo "${source_list[$i]}" | grep -qi "readme"
  then
    readme_index=$i
    break
  fi
done

# If a readme file exists, display its contents before everything else
if [ "$readme_index" -ge 0 ]
then
  readme_file="${source_list[$readme_index]}"
  echo "File path: $readme_file"

  echo
  echo "File contents:"

  echo
  cat "$readme_file"
  echo "----------------------------"
  unset source_list[$readme_index]
fi

# Generate a list of directories and files in the source list
directories=()
files=()
for file in "${source_list[@]}"
do
  # Check if the file exists
  if [ -e "$file" ]
  then
    # Check if the file is a directory
    if [ -d "$file" ]
    then
      # Add the directory to the list of directories
      directories+=("$file")
    else
      # Add the file to the list of files
      files+=("$file")
    fi
  fi
done

# Show the filetree from the current directory to each directory containing source files
if [ ${#directories[@]} -gt 0 ]
then
  echo "Filetree for directories containing source files:"
  tree --noreport --dirsfirst --filelimit 0 "${directories[@]}"
fi

# Loop through the list of source files
for file in "${files[@]}"
do
  # Display the file path relative to the current directory
  echo "File path: $file"

  # Display the file contents
  echo "File contents:"
  cat "$file"
  echo
  echo "----------------------------"
done