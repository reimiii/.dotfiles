#export PATH=$HOME/bin:$PATH
#
# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac
# .bashrc

# Source global definitions
# if [ -f /etc/bashrc ]; then
#     . /etc/bashrc
# fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"
fi

export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi

unset rc


# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-bash installation.
export OSH="$HOME/.oh-my-bash"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="bakke"

OMB_USE_SUDO=true

completions=(
  git
  composer
  ssh
  tmux
  docker-compose
  defaults
  gradle
  maven
  system
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
  ansible
  sudo
)

set -o vi

source "$OSH"/oh-my-bash.sh

# User configuration
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
alias svim='sudo -E -s nvim -c "set noundofile"' 
alias dc="docker compose"
# ssh
export SSH_KEY_PATH="~/.ssh/id_ed25519"

# neovim
# export NEOVIM=$HOME/bin/nvim-linux64
# export NODEJS=$HOME/bin/node-v20.10.0-linux-x64 
# export GOLANG=/usr/local/go

# export PATH=$NEOVIM/bin:$NODEJS/bin:$GOLANG/bin:$PATH

bind '"\C-g":"cht.sh\n"'
bind '"\C-f":"tmux-sessionizer\n"'
bind '"\C-p":"compose-chozer\n"'

export GPG_TTY=$(tty)
export TERM=kitty
export EDITOR="kitty -e nvim"  # Example for using Kitty as a text editor
export FILE_MANAGER=nemo  # Example for setting Nemo as default file manager

function pacman-optional-deps() {
 if [ $# -eq 0 ]; then 
    echo "No arguments specified. You must specify a package" 
    return 1 
  fi 
  deps=$(pacman -Si $1 | sed -n '/^Opt/,/^Conf/p' | sed '$d' | sed 's/^Opt[^:]*://g' | sed 's/^\s*//g' | sed 's/:.*$//g' | tr '\n' ' ')
  echo "Will install:"
  echo $deps
  sudo pacman -S --asdeps --needed $deps 
}

