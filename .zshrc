# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias cls='clear'
alias open='xdg-open .'
alias format='npx prettier --write resources/js'

PATH="$HOME/.config/composer/vendor/bin:$PATH"

ZSH_THEME="frontcube"

ZSH_DISABLE_COMPFIX="true"

CASE_SENSITIVE="true"

### ZSH OPTIONS ###
# Case sensitive auto completion
CASE_SENSITIVE="false"

# Automatic update configuration for oh-my-zsh (disabled, auto, reminder)
zstyle ':omz:update' mode auto

# oh-my-zsh auto update frequency (in days)
zstyle ':omz:update' frequency 1

# Autocorrect
ENABLE_CORRECTION="false"

# Prompt to show when a command is awaiting completion/is currently running
COMPLETION_WAITING_DOTS="true"

# Speeds up repository status checks for large repositories
DISABLE_UNTRACKED_FILES_DIRTY="true"


plugins=(
	git 
    copypath
    last-working-dir
	archlinux 
    laravel
	aliases
	zsh-256color 
	zsh-syntax-highlighting 
	)
source $ZSH/oh-my-zsh.sh

