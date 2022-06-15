# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
PATH=$HOME/bin:$PATH
export PATH

export SHELL=/bin/zsh
export EDITOR="nvim"
export LC_ALL=en_US.UTF-8
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export EDITOR=nvim
alias vim=nvim

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 7

plugins=(git brew gh kubectl tmux docker)

source $ZSH/oh-my-zsh.sh

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

HISTFILE=$HOME/.zsh/history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt inc_append_history
setopt extended_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify

setopt correct_all

[ -f "${HOME}/.dotoverrides/zshrc" ] && source ${HOME}/.dotoverrides/zshrc
