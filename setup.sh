#!/bin/bash
# Main setup script

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OS="$(uname -s)"

echo "🚀 Starting dotfiles installation..."

# Run OS-specific installation modules
if [ "$OS" = "Darwin" ]; then
  source "$DOTFILES_DIR/scripts/setup-macos.sh"
elif [ "$OS" = "Linux" ]; then
  source "$DOTFILES_DIR/scripts/setup-linux.sh"
else
  echo "⚠️ Unknown OS: $OS. Skipping OS-specific installation."
fi

# --- Shared Setup (Symlinks, etc.) ---
echo "🔗 Linking shared configuration files..."
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo "✅ All done! Restart your terminal or run: source ~/.zshrc"
