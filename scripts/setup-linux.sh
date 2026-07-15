linux.sh
#!/bin/bash
# Linux/Codespaces specific installation steps
echo "🐧 Running Linux setup..."

mkdir -p "$HOME/.local/bin"

# Install Starship locally
if ! command -v starship &> /dev/null; then
  echo "Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y --bin-dir "$HOME/.local/bin"
fi

# Install Zoxide locally
if ! command -v zoxide &> /dev/null; then
  echo "Installing Zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh -s -- --bin-dir "$HOME/.local/bin"
fi
