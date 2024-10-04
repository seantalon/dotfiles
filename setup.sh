#!/bin/bash

sudo apt-add-repository ppa:fish-shell/release-3 -y

sudo apt update && sudo apt install -y fish curl


# Change the default shell to fish
if [[ "$SHELL" != "/usr/bin/fish" ]]; then
    echo "Changing default shell to fish..."
    sudo chsh -s /usr/bin/fish $USER
fi

git clone https://github.com/pyenv/pyenv.git ~/.pyenv

cd ~/.pyenv && src/configure && make -C src

set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

curl -sS https://starship.rs/install.sh | sh -s -- -y

cp -r .config/* ~/.config/