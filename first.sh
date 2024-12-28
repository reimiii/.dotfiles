#!/usr/bin/env bash

mkdir -p ~/Dev/personal ~/Dev/work ~/Videos/CS/LL ~/Videos/CS/vd ~/Videos/CS/PZN

sudo pacman -S $(cat pacman.txt)

yay -S $(cat yay.txt)

if [[ -d ~/.config/i3 ]]; then
   mv ~/.config/i3 ~/.config/i3.defs 
fi

stow bin/ dunst/ fish/ i3/ idea/ kitty/ nvim/ rofi/ tmux/ wallpaper/

sudo gpasswd -a $USER docker
sudo gpasswd -a $USER video

echo "done..."
