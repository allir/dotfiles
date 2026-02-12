#!/usr/bin/env bash
set -euo pipefail

# Setup Homebrew
if command -v brew &>/dev/null; then
    echo "Homebrew is already installed"
    brew --version
    exit 0
fi

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" </dev/null
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null)"
brew analytics off
