#
# basic install script for dotfiles
#

GIT := $(shell which git)
# files you want to install
EXCLUDE := README.md Makefile install.sh vscode
FILES := $(shell ls)
SOURCES := $(filter-out $(EXCLUDE),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))
BREWFILE := Brewfile

DEFAULT_TARGETS := $(DOTFILES)

OS := $(shell uname -s)
ifeq ($(OS),Darwin)
HOMEBREW_LOCATION := /usr/local/bin
NVIM_LOCATION := /opt/homebrew/bin/nvim
else ifeq ($(OS),Linux)
HOMEBREW_LOCATION := /home/linuxbrew/.linuxbrew/bin
NVIM_LOCATION := /home/linuxbrew/.linuxbrew/bin/nvim
endif

.PHONY: homebrew
homebrew: $(HOMEBREW_LOCATION)/brew

.PHONY: ohmyzsh
ohmyzsh: sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# tasks
.PHONY : uninstall install

$(DOTFILES): $(addprefix ${HOME}/., %) : ${PWD}/%
	ln -fs $< $@

${HOME}/.zshrc: $(PWD)/zshrc
	ln -fs $(PWD)/zshrc $@

${HOME}/.config/Code/User/settings.json:
	install -d $(dir $@)
	ln -fs $(PWD)/vscode/settings.json $@

.PHONY: vscode
vscode: ${HOME}/.config/Code/User/settings.json

ifeq ($(CODESPACES), true)
install: ohmyzsh $(DEFAULT_TARGETS) brew-bundle codespaces vscode
else ifeq ($(OS), FreeBSD)
install: $(DEFAULT_TARGETS)
else ifeq ($(CI), true)
install: $(DEFAULT_TARGETS)
else
install: ohmyzsh $(DEFAULT_TARGETS) brew-bundle ohmyzsh
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

.PHONY: bundle-install
bundle-install:
	bundle install --gemfile=spec/Gemfile

.PHONY: spec
spec:
	bundle exec --gemfile=spec/Gemfile rspec --format=documentation spec/
