#!/bin/bash

dirs=()
dirs+=("/mnt/c/Users/chris/Documents")
dirs+=("/mnt/c/Users/chris/Downloads")
dirs+=("/mnt/c/Users/chris/Dropbox")
dirs+=("/mnt/c/Users/chris/.m2")
dirs+=("/mnt/c/dev")
dirs+=("/mnt/c/dev/projects")

for dir in "${dirs[@]}"; do
    target_dir="${dir%:*}"
    if [[ "${dir}" == *:* ]]; then
        symlink_name="${dir#*:}"
    else
        symlink_name="$(basename "${dir}")"
    fi
    symlink="$HOME/${symlink_name}"
    if [[ "$(readlink "${symlink}")" == "${target_dir}" ]]; then
        echo "The '${symlink_name}' symlink already exists."
    else
        echo "Creating '${symlink_name}' symlink to $target_dir"
        ln -s "${target_dir}" "${symlink}"
    fi
done
