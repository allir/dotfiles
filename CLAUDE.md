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

## Pitfalls

- **Homebrew paths differ by architecture.** Apple Silicon uses `/opt/homebrew`, Intel uses `/usr/local`. Always use an `if/elif` pattern — never hardcode one path. The canonical pattern is in `.shell/path`.
- **Bash ≠ zsh for history.** Zsh requires `SAVEHIST` (not `HISTFILESIZE`). Changes to history config in `.zprofile` must account for both shells.
- **`share_history` + `unsetopt inc_append_history` is intentional.** This keeps history sharing on read without writing every command immediately. Do not "fix" this.
- **Color aliases live in `.shell/profile`, not `commonrc`.** They are co-located with `CLICOLOR`, `LSCOLORS`, `GREP_OPTS`, and `LESS` so all color config stays in one place.
- **Avoid subprocesses in shell startup files.** Use parameter expansion defaults (e.g. `${GOPATH:-$HOME/go}`) instead of calling commands like `go env GOPATH`.
- **Pre-create shared directories before stow.** Run `mkdir -p ~/.local/bin` (and similar) before `stow --restow` to prevent stow from folding the entire directory into a single symlink, which would break other tools that install there.
- **Tmux/clipboard is cross-platform.** Clipboard bindings use `if-shell` to choose between `pbcopy` (macOS) and `xclip` (Linux). New clipboard bindings must follow this pattern.

## Plans

Design documents live in `docs/plans/`. Status is tracked in [`docs/plans/README.md`](docs/plans/README.md).

When creating a plan:
1. Create `docs/plans/YYYY-MM-DD-short-topic.md` — no status block in the file itself
2. Add a row to `docs/plans/README.md` with status `Planned` and empty commits column
3. Related plans share a name prefix (e.g. `shellcheck-audit-{high,medium,low}`)
4. On completion, update the row: status → `Done`, fill in commit hashes

Valid statuses: `Planned`, `In Progress`, `Done`, `Abandoned`.
