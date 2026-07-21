#!/bin/bash
# macOS specific installation steps using Homebrew Bundle
echo "🍎 Running macOS setup..."

if ! command -v brew &> /dev/null; then
  echo "❌ Error: Homebrew is not installed. Please install it first."
  exit 1
fi

# Run brew bundle using the Brewfile in the repository root
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo "📦 Installing packages from Brewfile..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
else
  echo "⚠️ Error: Brewfile not found at $DOTFILES_DIR/Brewfile"
  exit 1
fi

echo "🔗 Linking Ghostty config..."
mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/ghostty/config.ghostty" "$HOME/.config/ghostty/config.ghostty"
