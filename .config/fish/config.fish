if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_title
    set -l short_pwd (fish_prompt_pwd_dir_length=1 prompt_pwd)
    echo (whoami)"@"(hostname)": $short_pwd"
end

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

fish_add_path $HOME/.local/bin

starship init fish | source
