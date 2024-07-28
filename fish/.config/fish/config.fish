set PATH ~/bin $PATH
fish_add_path ~/Dev/jdk/jdk-21.0.4/bin/

bind \cf tmux-sessionizer
bind \cp compose-chozer
bind \cg cht.sh

#bind '"\C-g":"cht.sh\n"'
#bind '"\C-f":"tmux-sessionizer\n"'
#bind '"\C-p":"compose-chozer\n"'
# ini baru

function svim --wraps nvim --description 'sudo in nvim'
    sudo nvim -c "set noundofile" $argv
end

alias dc="docker compose"

# ssh
set -gx  SSH_KEY_PATH "~/.ssh/id_ed25519"

set -gx GPG_TTY $(tty)
set -gx TERM kitty
set -gx EDITOR "kitty -e nvim"  # Example for using Kitty as a text editor
set -gx FILE_MANAGER nemo  # Example for setting Nemo as default file manager

function opdeps --wraps ~/bin/pacman-optional-deps.sh --description 'install pacman opdeps'
    if test -z $argv
        echo "No arguments specified. You must specify a package"
        return 1
    end

    # Call the external script (replace with actual script path)
    ~/bin/pacman-optional-deps.sh $argv
end

