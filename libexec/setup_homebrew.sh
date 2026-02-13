#!/usr/bin/env bash
set -euo pipefail

# Setup Homebrew
if command -v brew &>/dev/null; then
    echo "Homebrew is already installed"
    brew --version
    exit 0
fi

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
brew analytics off
