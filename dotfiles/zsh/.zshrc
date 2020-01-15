export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
ZSH_CUSTOM=~/config/zshcustom

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --ignore --follow --glob "!.git/*"'
export FZF_BASE=~/.fzf

plugins=(git gopass fzf)

source $ZSH/oh-my-zsh.sh

export PATH=~/local/bin:$PATH
export LD_LIBRARY_PATH=~/local/lib

source $HOME/.cargo/env

compinit

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export VISUAL="vim"
export EDITOR="vim"

alias vim=nvim
alias vimrc="vim ~/.vimrc"

PATH=~/.npmlocal/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

ENV_PATH=~/local/env.sh
if [ -f $ENV_PATH ]; then
    source $ENV_PATH
fi
