if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_title
    # Set the directory length for abbreviation
    set -l short_pwd (fish_prompt_pwd_dir_length=1 prompt_pwd)
    
    # Set the window title to "username@hostname: short_pwd"
    echo (whoami)"@"(hostname)": $short_pwd"
end


alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#set -x PYENV_ROOT "$HOME/.pyenv"
#if test -d "$PYENV_ROOT/bin"
#    set -x PATH "$PYENV_ROOT/bin" $PATH
#end
#status --is-interactive; and pyenv init --path | source

set PATH $PATH /home/sean/.local/bin

starship init fish | source

pyenv init - | source
