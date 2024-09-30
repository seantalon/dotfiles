#!/bin/bash

# Install Fish shell
sudo apt update
sudo apt install -y fish

# Add Fish to the list of valid shells
if ! grep -q "/usr/bin/fish" /etc/shells; then
    echo "/usr/bin/fish" | sudo tee -a /etc/shells
fi

# Change the default shell to Fish for the current user
sudo chsh -s /usr/bin/fish sean

# Create the Fish configuration directory if it doesn't exist
mkdir -p ~/.config/fish

# Add the custom fish_title function and Starship prompt initialization
cat << 'EOF' >> ~/.config/fish/config.fish

# Function to set the terminal title
function fish_title
    # Set the directory length for abbreviation
    set -l short_pwd (fish_prompt_pwd_dir_length=1 prompt_pwd)

    # Set the window title to "username@hostname: short_pwd"
    echo (whoami)"@"(hostname)": $short_pwd"
end

# Initialize Starship prompt
starship init fish | source
EOF

echo "Fish has been installed, set as your default shell, and configured. Please log out and log back in for the changes to take effect."

