#!/bin/bash
. lib.sh
assert-has-config-host

echo setting up for $CONFIG_HOST

if [[ $CONFIG_HOST == "comus" ]]; then
    i-ppa "3v1n0/libfprint-vfs0090"
    i-ppa "yubico/stable"
    i-ppa "mmstick76/alacritty"
    i-ppa "plt/racket"

    # thinkpad specific
    i tlp
    i tlp-rdw
    i tp-smapi-dkms
    i acpi-call-dkms

    # system utils
    i pavucontrol
    i brightnessctl
    i fprint-demo
    i libpam-fprintd
    i yubikey-personalization-gui

    i-snap tusk
    i-snap discord
    i-snap spotify

    i alacritty
    i racket
    i mutt
    i w3m

    # display/window management
    i arandr
    i autorandr
    i xmonad
    i xmobar
    i stalonetray
    i suckless-tools # dmenu
    i feh
    i scrot
    i lxappearance
fi

# user utils
i stow
i curl
i wget
i htop
i tree
i git
i gnupg2
i scdaemon # smartcards

# shell/editor
i zsh
i xclip
i tmux
r vim
i python-neovim
i python3-neovim
i python-dev
i python-pip
i python3-dev
i python3-pip

# dev env
i cmake
i cloc

FZF_DIR=~/.fzf
if [ ! -d $FZF_DIR ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $FZF_DIR
    ~/.fzf/install --no-update-rc --all
fi

OH_MY_ZSH_DIR=~/.oh-my-zsh
OH_MY_ZSH_INSTALL_SCRIPT=https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
if [ ! -d $OH_MY_ZSH_DIR ]; then
    sh -c "$(curl -fsSL $OH_MY_ZSH_INSTALL_SCRIPT)" --unattended;
    #fix moved zshrc
    if [ -f ~/.zshrc.pre-oh-my-zsh ]; then
        rm ~/.zshrc
        mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
    fi
fi

if [ ! -d "~/.zplug" ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

RIPGREP_VERSION="11.0.1"
RIPGREP_DPKG="ripgrep_11.0.1_amd64.deb"
RIPGREP_BASE="https://github.com/BurntSushi/ripgrep/releases/download"
RIPGREP_URL="$RIPGREP_BASE/$RIPGREP_VERSION/$RIPGREP_DPKG"
if [ $(dpkg-count ripgrep) -eq 0 ]; then
    curl -LO $RIPGREP_URL
    sudo dpkg -i $RIPGREP_DPKG
    rm $RIPGREP_DPKG
fi

NVIM_PATH=~/local/bin/nvim
if [ ! -f $NVIM_PATH ]; then
    curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > $NVIM_PATH
    chmod +x $NVIM_PATH
fi

INKDROP_URL="https://api.inkdrop.app/download/linux/deb"
if [ $(dpkg-count inkdrop) -eq 0 ]; then
    curl -L $INKDROP_URL -o inkdrop.deb
    sudo dpkg -i inkdrop.deb
    rm inkdrop.deb
fi
