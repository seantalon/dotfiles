#!/bin/bash

sudo apt update && sudo apt install -y fish curl

cp -r ./config/* ~/.config

# Change the default shell to fish
if [[ "$SHELL" != "/usr/bin/fish" ]]; then
    echo "Changing default shell to fish..."
    sudo chsh -s /usr/bin/fish $USER
fi

curl -sS https://starship.rs/install.sh | sh -s -- -y

fish

source ~/.config/fish/config.fish