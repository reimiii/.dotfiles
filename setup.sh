#!/usr/bin/env bash

dir=~/vault

if [[ -d $dir ]]; then
    echo " "
    echo " !!! Directory vault exists !!! "   
    echo " "
    read -p "Want to remove the directory '$dir' (y/N)? " confirm
    
    confirm_lower=$(tr [A-Z] [a-z] <<< "$confirm")

    if [[ "$confirm_lower" != "y" ]]; then
        echo "Directory deletion cancelled."
        exit 0
    fi

    echo "Removing directory '$dir'..."
    rm -rf "$dir"

    if [ $? -eq 0 ]; then
        echo "Directory '$dir' deleted successfully."
    else
        echo "Error: Failed to remove directory '$dir'."
    fi

    echo " "
fi

cd ~ && git clone https://github.com/reimiii/vault.git

echo " "
echo "decrypt with ansible-vault...(ssh and gpg)"
cd $dir && ansible-vault decrypt .ssh/* gpg/key.asc

echo " "
echo "copy .gitconfig to home..."

cp $dir/.gitconfig ~

if [[ -d ~/.ssh ]]; then
    echo " "
    echo " !!! Directory .ssh exists !!! "   
    echo " "
    echo "remove directory .ssh in home..."
    rm -rf ~/.ssh

    echo " "
fi

echo "copy .ssh to home..."

cp -r $dir/.ssh ~

echo "setup ssh..."

eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519

echo "setup gpg..."

gpg --import $dir/gpg/key.asc

echo " "
echo "change remote vault to ssh..."
cd $dir \
    && git remote -v \
    && git remote set-url origin git@github.com:reimiii/vault.git \
    && git remote -v

echo "change remote .dotfiles to ssh..."
cd ~/.dotfiles/ \
    && git remote -v \
    && git remote set-url origin git@github.com:reimiii/.dotfiles.git \
    && git remote -v
