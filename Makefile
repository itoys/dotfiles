#
# basic install script for dotfiles
#

GIT := $(shell which git)
# files you want to install
EXCLUDE := README.md Makefile install.sh vscode zshrc
FILES := $(shell ls)
SOURCES := $(filter-out $(EXCLUDE),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))
BREWFILE := Brewfile

DEFAULT_TARGETS := $(DOTFILES)

OS := $(shell uname -s)
ifeq ($(OS),Darwin)
HOMEBREW_LOCATION := /usr/local/bin
else ifeq ($(OS),Linux)
HOMEBREW_LOCATION := /home/linuxbrew/.linuxbrew/bin
endif

.PHONY: homebrew
homebrew: $(HOMEBREW_LOCATION)/brew

.PHONY: ohmyzsh
ohmyzsh:
	curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o install-oh-my-zsh.sh;
	yes | sh install-oh-my-zsh.sh
	rm -f install-oh-my-zsh.sh

# tasks
.PHONY : uninstall install

$(DOTFILES): $(addprefix ${HOME}/., %) : ${PWD}/%
	ln -fs $< $@

${HOME}/.config/Code/User/settings.json:
	install -d $(dir $@)
	ln -fs $(PWD)/vscode/settings.json $@

${HOME}/.zshrc: $(PWD)/zshrc
	ln -fs $(PWD)/zshrc $@

.PHONY: vscode
vscode: ${HOME}/.config/Code/User/settings.json

ifeq ($(CODESPACES), true)
install: $(DEFAULT_TARGETS) brew-bundle ${HOME}/.zshrc codespaces vscode
else ifeq ($(OS), FreeBSD)
install: $(DEFAULT_TARGETS)
else ifeq ($(CI), true)
install: $(DEFAULT_TARGETS)
else
install: $(DEFAULT_TARGETS) brew-bundle ohmyzsh ${HOME}/.zshrc
endif

.PHONY: brew-bundle
brew-bundle: homebrew
	$(HOMEBREW_LOCATION)/brew bundle install --no-lock --file $(BREWFILE)

$(HOMEBREW_LOCATION)/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/install_homebrew.sh
	/bin/bash < /tmp/install_homebrew.sh

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done

.PHONY: codespaces
codespaces:
	./setup-codespaces
