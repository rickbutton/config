#!/bin/bash
. lib.sh
assert-has-config-host

function dot() {
    stow -d dotfiles -t $HOME $1
}

if [[ $CONFIG_HOST == "comus" ]]; then
    dot alacritty
    dot git

    dot stalonetray
    dot xmobar
    dot xmonad
    dot xorg

    dot fonts
    dot gtk
fi

dot tmux
dot vim
dot zsh

