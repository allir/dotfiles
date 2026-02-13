# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal macOS/Linux dotfiles repository for Aðalsteinn Rúnarsson. Manages shell configuration, system tools, Kubernetes utilities, and application settings via symlinks and automated setup scripts.

## Validation

```bash
# Lint all shell scripts
shellcheck install libexec/*.sh libexec/macos/*.sh bin/* .shell/commonrc .shell/awspro
```

No test suite — validate changes by running `shellcheck` and testing interactively in a new shell.

## Installation

```bash
# Remote one-liner
curl -s https://raw.githubusercontent.com/allir/dotfiles/main/remote_install | bash

# Or manual
git clone https://github.com/allir/dotfiles.git ~/.dotfiles
~/.dotfiles/install
```

The `install` script detects platform (Darwin/Linux), requests sudo upfront with a keep-alive loop, then runs setup scripts from `libexec/` in sequence. On macOS: Xcode CLI tools → Homebrew → Brewfile → Claude Code → shell registration → symlinks → SSH → iTerm2 → Dock → Terminal → bin scripts. Linux runs a subset (sudo → symlinks → SSH).

## Architecture

**Shell configuration chain:**
- `.bash_profile` / `.zprofile` → `.shell/profile` (env vars) → `.shell/path` (PATH setup)
- `.bashrc` / `.zshrc` → `.shell/commonrc` (shared aliases/functions)
- `.shell/path` sets GNU tools precedence over BSD, adds Go/Rust/Krew/`.local/bin` paths

**Drop-in config directories:** `.zshrc` sources `~/.zshrc.d/*.zshrc` and `.bashrc` sources `~/.bashrc.d/*.bashrc` — use these for machine-local or private config that shouldn't be tracked in git.

**Setup scripts (`libexec/`):** Modular scripts called by `install` — symlinks, SSH, Homebrew, Krew plugins, iTerm2, and macOS-specific configs under `libexec/macos/`.

**Symlink strategy (`libexec/setup_symlinks.sh`):** All dot-prefixed files/dirs at repo root (except `.git`, `.gitignore`, `.claude`) get symlinked to `$HOME`. Non-dot root files are also symlinked. Scripts in `bin/` are symlinked to `~/.local/bin`.

**Package management:** `Brewfile` for Homebrew formulae/casks, `Krewfile` for kubectl Krew plugins, `add-helm-repos.sh` for Helm chart repos.

**Key utilities:** `.shell/awspro` provides `awspro` function for interactive AWS profile switching (uses fzf when available). `share/terminal/` contains macOS Terminal.app themes.

## Key conventions

- Shell scripts use bash (`#!/usr/bin/env bash` or `#!/bin/bash`) with `set -euo pipefail`
- Aliases and functions shared between bash/zsh go in `.shell/commonrc`
- Custom kubectl plugins in `bin/` follow the `kubectl-<name>` naming convention
- Git config supports local overrides via `~/.gitconfig.local` (included but not tracked)
- Tmux prefix is `Ctrl+a`; Vim leader is `,`
