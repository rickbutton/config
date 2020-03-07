#!/bin/bash
. lib.sh
assert-has-config-host

function dot() {
    stow -d dotfiles -t $HOME $1
}

if [[ $CONFIG_HOST == "comus" ]]; then
    dot git

    dot comus/alacritty
    dot comus/stalonetray
    dot comus/xmobar
    dot comus/xmonad
    dot comus/xorg

    dot comus/fonts
    dot comus/gtk
fi
if [[ $CONFIG_HOST == "geras" ]]; then
    dot git
fi

dot tmux
dot vim
dot zsh

