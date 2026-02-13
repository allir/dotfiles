# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal macOS/Linux dotfiles repository for Aðalsteinn Rúnarsson. Manages shell configuration, system tools, Kubernetes utilities, and application settings via symlinks and automated setup scripts.

## Validation

```bash
# Lint all shell scripts
shellcheck install libexec/*.sh libexec/macos/*.sh stow/bin/.local/bin/* stow/shell/.shell/commonrc stow/shell/.shell/awspro
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

**Stow-based symlink management:** All linkable config lives under `stow/` in per-tool packages that mirror `$HOME`. The `install` script calls `stow --restow` to create symlinks. Packages: `shell`, `git`, `vim`, `tmux`, `screen`, `ssh`, `iterm` (macOS only), `bin`, `misc`.

To add a new config file: place it in the appropriate package under `stow/<package>/` mirroring its `$HOME` path (e.g. `stow/git/.gitconfig` → `~/.gitconfig`). To add a new package: create `stow/<name>/`, add files, and list the package in the `stow` command in `install`.

**Shell configuration chain:**
- `stow/shell/.bash_profile` / `.zprofile` → `.shell/profile` (env vars) → `.shell/path` (PATH setup)
- `stow/shell/.bashrc` / `.zshrc` → `.shell/commonrc` (shared aliases/functions)
- `.shell/path` sets GNU tools precedence over BSD, adds Go/Rust/Krew/`.local/bin` paths

**Drop-in config directories:** `.zshrc` sources `~/.zshrc.d/*.zshrc` and `.bashrc` sources `~/.bashrc.d/*.bashrc` — use these for machine-local or private config that shouldn't be tracked in git.

**Setup scripts (`libexec/`):** Modular scripts called by `install` — Homebrew, Krew plugins, iTerm2, and macOS-specific configs under `libexec/macos/`.

**Package management:** `Brewfile` for Homebrew formulae/casks (includes `stow`), `Krewfile` for kubectl Krew plugins, `add-helm-repos.sh` for Helm chart repos.

**Key utilities:** `stow/shell/.shell/awspro` provides `awspro` function for interactive AWS profile switching (uses fzf when available). `share/terminal/` contains macOS Terminal.app themes.

## Key conventions

- Shell scripts use bash (`#!/usr/bin/env bash` or `#!/bin/bash`) with `set -euo pipefail`
- Aliases and functions shared between bash/zsh go in `.shell/commonrc`
- Custom kubectl plugins in `stow/bin/.local/bin/` follow the `kubectl-<name>` naming convention
- Git config supports local overrides via `~/.gitconfig.local` (included but not tracked)
- Tmux prefix is `Ctrl+a`; Vim leader is `,`
