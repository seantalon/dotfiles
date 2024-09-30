#!/bin/bash

# Get the absolute path of the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Iterate through all files and directories in the dotfiles directory
for item in "$DOTFILES_DIR"/*; do
    # Extract the base name (e.g., .config, .bashrc)
    basename=$(basename "$item")
    target="$HOME/$basename"
    
    # Check if a symlink already exists
    if [ -L "$target" ]; then
        echo "Symlink for $basename already exists. Skipping."
    elif [ -e "$target" ]; then
        echo "$target already exists as a regular file or directory. Please back it up or remove it before running this script."
    else
        # Create the symlink
        ln -s "$item" "$target"
        echo "Symlink created: $target -> $item"
    fi
done

# Change the default shell to fish
if [[ "$SHELL" != "/usr/bin/fish" ]]; then
    echo "Changing default shell to fish..."
    sudo chsh -s /usr/bin/fish $USER
fi

sudo apt update && sudo apt install -y fish curl

curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin