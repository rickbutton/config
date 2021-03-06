HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -v
bindkey -v '^?' backward-delete-char

autoload -Uz compinit
compinit
zstyle :compinstall filename '~/.zshrc'

VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
ZSH_CUSTOM=~/config/zshcustom

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --ignore --follow --glob "!.git/*"'
export FZF_BASE=~/.fzf

plugins=(git fzf)

source $ZSH/oh-my-zsh.sh

export PATH=~/local/bin:$PATH
export LD_LIBRARY_PATH=~/local/lib

[ -f ~/.cargo/env ] && source ~/.cargo/env

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export VISUAL="nvim"
export EDITOR="nvim"
export LESS="-R"

alias vi=nvim
alias vim=nvim
alias vimrc="nvim ~/.vimrc"

alias ta="tmux attach -t"

PATH=~/.npmlocal/bin:$PATH
PATH=~/config/bin:$PATH

source ~/.zplug/init.zsh

zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

ENV_PATH=~/local/env.sh
if [ -f $ENV_PATH ]; then
    source $ENV_PATH
fi
