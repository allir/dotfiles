# dotfiles

Personal macOS/Linux dotfiles. Manages shell, git, vim, tmux, and other configs using [GNU Stow](https://www.gnu.org/software/stow/) for symlink management.

## Installation

Before installing, make sure your system is up to date:

* `sudo softwareupdate -i -a`

```bash
curl -s https://raw.githubusercontent.com/allir/dotfiles/main/remote_install | bash
```

Or manually:

```bash
git clone https://github.com/allir/dotfiles.git ~/.dotfiles
~/.dotfiles/install
```

## Structure

Configs live in `stow/` as per-tool packages that mirror `$HOME`:

```text
stow/
├── bin/       # Custom scripts (~/.local/bin/)
├── git/       # Git config
├── shell/     # Bash & Zsh (shared via .shell/commonrc)
├── ssh/       # SSH config
├── tmux/      # Tmux (prefix: Ctrl+a)
├── vim/       # Vim (leader: ,)
└── ...        # screen, iterm, misc
```

Machine-local config goes in `~/.bashrc.d/` or `~/.zshrc.d/` (not tracked).

## macOS

On macOS the install script additionally handles:

- **Xcode CLI Tools** — installed automatically if missing
- **Homebrew** — installs Homebrew and runs the `Brewfile` (GNU coreutils, dev tools, apps)
- **Shell** — registers Homebrew zsh/bash in `/etc/shells` and sets zsh as default
- **iTerm2** — loads color schemes and preferences from `stow/iterm/`
- **Dock** — resets and configures Dock apps and appearance
- **Terminal.app** — imports a custom profile from `share/terminal/`

On Linux only symlinks and SSH setup run.
