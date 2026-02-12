#!/usr/bin/env bash
set -euo pipefail

# Install Claude Code CLI using native installer
# https://claude.ai/code

if command -v claude &>/dev/null; then
    echo "Claude Code is already installed"
    claude --version
    exit 0
fi

curl -fsSL https://claude.ai/install.sh | bash
