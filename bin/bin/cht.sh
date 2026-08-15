#!/usr/bin/env bash

selected=`cat ~/bin/tmux-cht-languages ~/bin/tmux-cht-command | fzf`

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/bin/tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    if [[ -z $query ]]; then
        oke=`curl -s -S cht.sh/$selected/rosetta/:list | fzf`
        tmux neww bash -c "curl -s -S cht.sh/$selected/rosetta/$oke | less"
        echo "$oke - rosetta...."
    else
        tmux neww bash -c "curl -s -S cht.sh/$selected/$query | less"
    fi
else
    tmux neww bash -c "curl -s -S cht.sh/$selected~$query | less"
fi

