#!/usr/bin/env bash
set -euo pipefail

# Setup Homebrew
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" </dev/null
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null)"
brew analytics off
