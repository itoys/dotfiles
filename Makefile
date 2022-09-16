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
brew-bundle: homebrew
	bundle install

.PHONY: $(DOTFILES)
$(DOTFILES):
	ln -fs $(PWD)/$@ ${HOME}/.$@

.PHONY: ohmyzsh
ohmyzsh:
	rm -rf ${HOME}/.oh-my-zsh
	curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o install-oh-my-zsh.sh;
	yes | sh install-oh-my-zsh.sh
	rm -rf install-oh-my-zsh.sh
	git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	ln -fs $(PWD)/zshrc ${HOME}/.zshrc

.PHONY: codespaces
codespaces:
	./setup-codespaces

# tasks

ifeq ($(CODESPACES), true)
install: $(DOTFILES) brew-bundle homebrew ohmyzsh codespaces
else
install: $(DOTFILES) brew-bundle homebrew ohmyzsh
endif
