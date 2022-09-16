export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

plugins=(
  git
  rails
  ruby
  copyfile
  docker
  kubectl
  github
  golang
  bundler
  gem
  brew
  macos
  history
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code -w'
fi

# eval "$(/opt/homebrew/bin/brew shellenv)"

export GITHUB_TOKEN=$BUILD_TOKEN
export GHCR_TOKEN=$BUILD_TOKEN
export GITHUB_USER=itoys

export GEM_HOME="$HOME/.gem"
export GOPATH="$HOME/go"

PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
PATH=$HOME/bin:$PATH
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$GEM_HOME/bin"
export PATH

export SHELL=/bin/zsh
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

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

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
[ -f "${HOME}/zshrc" ] && source ${HOME}/zshrc