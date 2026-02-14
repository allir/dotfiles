# README Update

Refresh the README with a clearer intro, structured content, and macOS documentation.

## Context

The README only said "My macOS dotfiles repo" and listed installation commands. It didn't mention Linux support, GNU Stow, the `stow/` package structure, or what the install script does on macOS.

## Changes

### Phase 1 — Refresh intro, Installation, and Structure

- Rewrote header to mention Linux support and GNU Stow
- Tightened the Installation section (removed redundant "Prerequisites" sub-section)
- Added a Structure section with a `stow/` directory tree and package descriptions
- Noted `~/.bashrc.d/` and `~/.zshrc.d/` drop-in directories for machine-local config

### Phase 2 — Add macOS section

Appended a `## macOS` section documenting what the install script handles on Darwin:

- Xcode CLI Tools
- Homebrew + Brewfile
- Shell registration (`/etc/shells`) and default shell
- iTerm2 color schemes and preferences
- Dock reset and configuration
- Terminal.app custom profile

Also noted that Linux only runs symlinks and SSH setup.

## File modified

- `README.md`
