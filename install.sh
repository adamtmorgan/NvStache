#!/bin/bash

# Creates symlinks from repo into their default locations in `~` and `~/.config`.

SCRIPT_DIR="$(dirname "$(realpath "$0")")" # path for script directory

# Links a source to a destination and handles edge cases
function try_link() {
    configName=$1
    sourcePath=$2
    destinationPath=$3

    if [ ! -f "$sourcePath" ]; then
        echo "Config for $configName not found."
    elif [ ! -e "$destinationPath" ]; then
        ln -s "$sourcePath" "$destinationPath"
        echo "Config for $configName was symlinked to $destinationPath."
    elif [ -L "$destinationPath" ]; then
        rm "$destinationPath"
        ln -s "$sourcePath" "$destinationPath"
        echo "Overwrote config symlink for $configName at $destinationPath"
    elif [ -f "$destinationPath" ]; then
        mv "$destinationPath" "$destinationPath.bak"
        ln -s "$sourcePath" "$destinationPath"
        echo "Expected symlink path for $configName already has a file. Moved file to $destinationPath.bak and replaced with symlink."
    elif [ -d destinationPath ]; then
        mv "$destinationPath" "$destinationPath.bak"
        ln -s "$sourcePath" "$destinationPath"
        echo "Expected symlink path for $configName already has a directory. Moved dir to $destinationPath.bak and replaced with symlink."
    fi
}

# Move NvStache config
try_link "NvStache" "$SCRIPT_DIR" "$HOME/.config/nvim"
