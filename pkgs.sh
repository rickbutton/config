#!/bin/bash
. lib.sh
assert-has-config-host

echo setting up for $CONFIG_HOST

if [[ $CONFIG_HOST == "comus" ]]; then
    i-ppa "3v1n0/libfprint-vfs0090"
    i-ppa "yubico/stable"
    i-ppa "mmstick76/alacritty"

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

    i alacritty

    # display/window management
    i xmonad
    i xmobar
    i stalonetray
    i suckless-tools # dmenu
    i feh
    i scrot
    i lxappearance
fi

i-apt-key "https://api.bintray.com/orgs/gopasspw/keys/gpg/public.key" "gopass"
i-apt-key "https://dev.nodesource.com/gpgkey/nodesource.gpg.key" "nodesource"

# ppas
i-ppa "plt/racket"
i-deb "https://dl.bintray.com/gopasspw/gopass trusty main"
i-deb-src "https://deb.nodesource.com/node_12.x bionic main"

# user utils
i stow
i curl
i wget
i htop
i tree
i git
i gnupg2
i scdaemon
i gopass

# shell/editor
i zsh
i xclip
i tmux
i vim

# dev env
i nodejs
i cmake
i racket
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


RIPGREP_VERSION="11.0.1"
RIPGREP_DPKG="ripgrep_11.0.1_amd64.deb"
RIPGREP_BASE="https://github.com/BurntSushi/ripgrep/releases/download"
RIPGREP_URL="$RIPGREP_BASE/$RIPGREP_VERSION/$RIPGREP_DPKG"
if [ $(dpkg-count ripgrep) -eq 0 ]; then
    curl -LO $RIPGREP_URL
    sudo dpkg -i $RIPGREP_DPKG
    rm $RIPGREP_DPKG
fi
