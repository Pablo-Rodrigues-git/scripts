#!/bin/bash

# List of hook files to be installed
hook_files=("prepare-commit-msg" "pre-commit" "pre-push")

# Get the root directory of the git repository
root_dir=$(git rev-parse --show-toplevel)

# Loop through the hook files and copy them to the .git/hooks directory
for file in "${hook_files[@]}"; do
    if [ -f "${root_dir}/scripts/gitflow/${file}" ]; then
        echo "Installing ${file}..."
        cp "${root_dir}/scripts/gitflow/${file}" "${root_dir}/.git/hooks/"
        chmod +x "${root_dir}/.git/hooks/${file}"
        echo "${file} installed successfully."
    else
        echo "Error: ${file} does not exist in the /scripts directory."
    fi
done

echo "Hook installation completed."
