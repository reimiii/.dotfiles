#!/bin/bash

deps=$(pacman -Si "$1" | sed -n '/^Opt/,/^Conf/p' | sed '$d' | sed 's/^Opt[^:]*://g' | sed 's/^\s*//g' | sed 's/:.*$//g' | tr '\n' ' ')

echo "Will install:"
echo "$deps"

sudo pacman -S --asdeps --needed $deps

