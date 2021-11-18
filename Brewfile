def macos?
  RUBY_PLATFORM =~ /darwin/
end

def linux?
  RUBY_PLATFORM =~ /linux/
end

brew "bat"
brew "fd"
brew "neovim"
brew "ripgrep"
brew "tmux"

if macos?
  brew "git"
  brew "gh", args: ["HEAD"]
end
