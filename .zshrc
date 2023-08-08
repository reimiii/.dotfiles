# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# toolbox thing
export PATH=$HOME/.local/bin:$PATH

# JDK
#export JAVA_HOME=$HOME/Dev/JDK/17
export JAVA_HOME=$HOME/Dev/JDK/20

# Maven
export MAVEN_HOME=$HOME/Dev/Apache/apache-maven-3.8.8

export PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="random"

ZSH_DISABLE_COMPFIX="true"

CASE_SENSITIVE="true"

# Aliases
alias vim=nvim

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
	aliases
	archlinux
	zsh-syntax-highlighting 
	emotty
	emoji
	)
source $ZSH/oh-my-zsh.sh
