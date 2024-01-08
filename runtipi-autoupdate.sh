#!/usr/bin/env bash
 
# Function to compare semantic versions
compare_major_version() {
    local major_version1=$(echo $1 | cut -d. -f1)
    local major_version2=$(echo $2 | cut -d. -f1)
 
    if [[ "$major_version1" == "$major_version2" ]]; then
        return 0
    else
        return 1
    fi
}
 
# Get Current Version of Runtipi
runtipi_path=/path/to/runtipi # Change this to the path of your runtipi installation.
current_version=$(cat $runtipi_path/VERSION)
 
# Get the latest release information from GitHub API
latest_release=$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/runtipi/runtipi/releases/latest)
 
# Extract the tag name from the release information
tag_name=$(echo "$latest_release" | grep -o '"tag_name": "[^"]*' | cut -d'"' -f4)
 
# Compare major version numbers
compare_major_version "$tag_name" "$current_version"
major_version_match=$?
 
# Check if major versions are the same and if the latest release is newer than the current version
if [[ $major_version_match -eq 0 ]] && [[ "$tag_name" > "$current_version" ]]; then
    echo "A new release is available: $tag_name"
    cd $runtipi_path
    echo "Backing up current version"
    if [ ! -d "$runtipi_path/backups" ]; then
        mkdir -p $runtipi_path/backups
    fi
    tar -czvf runtipi-backup-$current_version.tar.gz --exclude=media --exclude=backups * 
    mv runtipi-backup-$current_version.tar.gz $runtipi_path/backups
    echo "Starting update"
    $runtipi_path/runtipi-cli update latest
else
    echo "No new release found or major version mismatch"
fi
