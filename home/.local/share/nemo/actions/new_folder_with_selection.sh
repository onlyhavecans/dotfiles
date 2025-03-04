#!/bin/bash

## Add " 1" to a name, or increment the space delemited number at the end
incremen_name() {
  local name="$1"

  if [[ "$name" =~ (.+ )([1-9]+)$ ]]; then
    local base="${BASH_REMATCH[1]}"
    local num="${BASH_REMATCH[2]}"

    local incremented=$((10#$num + 1))
    echo "${base}${incremented}"
  else
    echo "$name 1"
  fi
}

## Main
current_dir=$1
shift

# Gets the new folder name
new_folder=$(zenity --entry --entry-text="New Folder with Files" --width 600 --title="Create New Folder" --text="Enter the name of the new folder")

# cancel on empty
if [ -z "$new_folder" ]; then
  exit 0
fi

dest_dir="$current_dir/$new_folder"

# macOS like folder colission prevention
while [ -d "$dest_dir" ]; do
  dest_dir=$(incremen_name "$dest_dir")
done

if ! mkdir "$dest_dir"; then
  zenity --error --width 350 --title="Error Creating Folder" --text="mkdir returned $?"
  exit 1
fi

mv "${@}" --target-directory="$dest_dir"
