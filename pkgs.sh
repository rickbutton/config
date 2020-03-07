#!/bin/bash
. lib.sh
assert-has-config-host

echo setting up for $CONFIG_HOST

HOST_PKG_PATH=pkgs/$CONFIG_HOST.sh
if [ -f $HOST_PKG_PATH ]; then
    source $HOST_PKG_PATH
fi

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

if [ ! -d "~/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi