def macos?
  RUBY_PLATFORM =~ /darwin/
end

brew "bat"
brew "fd"
brew "ripgrep"
brew "tmux"

if macos?
  cask "iterm2"
  brew "git"
  brew "gh", args: ["HEAD"]
end
