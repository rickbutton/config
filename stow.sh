#!/bin/bash
. lib.sh
assert-has-config-host

function dot() {
    stow -d dotfiles -t $HOME $1
}
function hdot() {
    stow -d dotfiles/$CONFIG_HOST -t $HOME $1
}

if [[ $CONFIG_HOST == "comus" ]]; then
    dot git

    hdot alacritty
    hdot stalonetray
    hdot xmobar
    hdot xmonad
    hdot xorg

    hdot fonts
    hdot gtk
fi
if [[ $CONFIG_HOST == "geras" ]]; then
    dot git

    hdot iterm2
    hdot skhd
    hdot yabai
fi

dot tmux
dot vim
dot zsh

