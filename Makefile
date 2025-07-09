DOTFILES := ripgreprc gitconfig
BREWFILE := Brewfile

OS := $(shell uname -s)
ifeq ($(OS),Darwin)
HOMEBREW_LOCATION := /usr/local/bin
else ifeq ($(OS),Linux)
HOMEBREW_LOCATION := /home/linuxbrew/.linuxbrew/bin
endif

## Targets

$(HOMEBREW_LOCATION)/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/install_homebrew.sh
	/bin/bash < /tmp/install_homebrew.sh

.PHONY: homebrew
homebrew: $(HOMEBREW_LOCATION)/brew

.PHONY: brew-bundle
brew-bundle: homebrew
	$(HOMEBREW_LOCATION)/brew bundle install --no-lock --file $(BREWFILE)

.PHONY: gem-bundle
gem-bundle: 
	bundle install

.PHONY: $(DOTFILES)
$(DOTFILES):
	ln -fs $(PWD)/$@ ${HOME}/.$@

.PHONY: ohmyzsh
ohmyzsh:
	rm -rf ${HOME}/.oh-my-zsh
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install-oh-my-zsh.sh;
	yes | sh install-oh-my-zsh.sh
	rm -rf install-oh-my-zsh.sh
	git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	ln -fs $(PWD)/zshrc ${HOME}/.zshrc

.PHONY: p10k
p10k:
	mkdir -p ${HOME}/.oh-my-zsh/custom/themes
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${HOME}/.oh-my-zsh/custom/themes/powerlevel10k
	ln -fs $(PWD)/p10k.zsh $(HOME)/.p10k.zsh
	zsh -ic "source $(HOME)/.zshrc"

.PHONY: codespaces
codespaces:
	./setup-codespaces

# tasks

ifeq ($(CODESPACES), true)
# export HOMEBREW_INSTALL_FROM_API="1"
# install: $(DOTFILES) brew-bundle gem-bundle ohmyzsh codespaces
install: $(DOTFILES) gem-bundle ohmyzsh p10k codespaces
else
install: $(DOTFILES) brew-bundle gem-bundle ohmyzsh p10k
endif
