def macos?
  RUBY_PLATFORM =~ /darwin/
end

def linux?
  RUBY_PLATFORM =~ /linux/
end

brew "bat"
brew "fd"
brew "neovim"
brew "oras"
brew "ripgrep"
brew "tmux"

if macos?
  cask "iterm2"
  brew "git"
  brew "gh", args: ["HEAD"]
end
