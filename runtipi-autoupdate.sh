#!/usr/bin/env bash

# Get Current Version of Runtipi
file_path=/opt/runtipi # Change this to the path of your runtipi installation.
current_version=$(cat $file_path/VERSION)
current_version_number=$(echo $current_version | tr -cd '[:digit:]')

# Get the latest release information from GitHub API
latest_release=$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/runtipi/runtipi/releases/latest)

# Extract the tag name from the release information
tag_name=$(echo "$latest_release" | grep -o '"tag_name": "[^"]*' | cut -d'"' -f4)
tag_name_number=$(echo $tag_name | tr -cd '[:digit:]')

# Check if the latest release is newer than the current version and update if necessary
if [[ "$tag_name_number" > "$current_version_number" ]]; then
    echo "A new release is available: $tag_name"
    cd $file_path
    echo "Backing up current version"
    if [ ! -d "$file_path/backups" ]; then
    mkdir -p $file_path/backups
    fi 
    tar -czvf runtipi-backup-$current_version.tar.gz --exclude=media --exclude=backups * 
    mv runtipi-backup-$current_version.tar.gz $file_path/backups
    echo "Starting update"
    $file_path/runtipi-cli update latest
else
    echo "No new release found"
fi
