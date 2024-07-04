set PATH ~/bin $PATH

bind \cf tmux-sessionizer
bind \cp compose-chozer
bind \cg cht.sh

#bind '"\C-g":"cht.sh\n"'
#bind '"\C-f":"tmux-sessionizer\n"'
#bind '"\C-p":"compose-chozer\n"'

function svim --wraps nvim --description 'sudo in nvim'
    sudo nvim -c "set noundofile" $argv
end

alias dc="docker compose"
alias add-to-github "git init && git add . && git commit -m 'Initial commit' && git branch -M main && git remote add origin '$argv[1]' && git push -u origin main"
alias dynamic-push "git add . && git commit -m '$argv[1]' && git push"


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

