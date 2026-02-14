# Plan: Restructure dotfiles to use GNU Stow with per-tool packages

## Context

The current dotfiles repo has a mix-and-match approach to symlinking:

1. **Dot-prefixed files at root** are symlinked via a custom `setup_symlinks.sh` with a growing exclusion list (`NOLINK=". .. .git .gitignore .claude"`)
2. **SSH config** lives at `var/lib/ssh/config` and requires a separate `setup_ssh.sh` script
3. **bin/ scripts** are symlinked to `~/.local/bin/` via inline logic in `install`

This means three separate symlink mechanisms, a fragile exclusion list, and repo-management files mixed with linkable configs.

**Goal:** Adopt GNU Stow with per-tool packages under a `stow/` directory. Each tool/config gets its own package directory that mirrors `$HOME`. Only files intended for linking live inside packages; everything else (install, Brewfile, docs) stays outside.

## Proposed directory structure

```
~/.dotfiles/
│
├── stow/
│   ├── shell/                     # bash + zsh + shared shell config (combined)
│   │   ├── .bash_profile
│   │   ├── .bashrc
│   │   ├── .zprofile
│   │   ├── .zshrc
│   │   └── .shell/
│   │       ├── profile
│   │       ├── path
│   │       ├── commonrc
│   │       ├── awspro
│   │       └── bash-git-prompt-colors
│   ├── git/
│   │   └── .gitconfig
│   ├── vim/
│   │   ├── .vimrc
│   │   └── .vim/
│   │       └── colors/
│   │           ├── molokai.vim
│   │           └── solarized.vim
│   ├── tmux/
│   │   └── .tmux.conf
│   ├── screen/
│   │   └── .screenrc
│   ├── ssh/
│   │   └── .ssh/
│   │       └── config            # moved from var/lib/ssh/config
│   ├── iterm/
│   │   └── .iterm/
│   │       ├── com.googlecode.iterm2.plist
│   │       └── colors/
│   │           ├── allir.itermcolors
│   │           └── ... (all color schemes)
│   ├── bin/
│   │   └── .local/
│   │       └── bin/
│   │           ├── brewup
│   │           ├── kubectl-breakout
│   │           └── kubectl-decode
│   └── misc/
│       └── .hushlogin
│
├── install                        # orchestrator (updated)
├── remote_install                 # unchanged
├── Brewfile                       # unchanged (+ stow added)
├── Krewfile                       # unchanged
├── add-helm-repos.sh              # unchanged
├── CLAUDE.md                      # updated
├── README.md                      # unchanged
├── .gitignore                     # updated
├── .claude/                       # unchanged (never linked)
├── libexec/                       # minus setup_symlinks.sh and setup_ssh.sh
│   ├── setup_homebrew.sh
│   ├── setup_sudoers.sh
│   ├── setup_claude.sh
│   ├── setup_iterm.sh
│   ├── setup_krew_plugins.sh
│   └── macos/
├── share/                         # terminal themes etc.
└── docs/
```

## Package inventory

| Package | Contents | Notes |
|---------|----------|-------|
| `shell` | `.bash_profile`, `.bashrc`, `.zprofile`, `.zshrc`, `.shell/*` | All shell config combined |
| `git` | `.gitconfig` | |
| `vim` | `.vimrc`, `.vim/colors/` | |
| `tmux` | `.tmux.conf` | |
| `screen` | `.screenrc` | |
| `ssh` | `.ssh/config` | Moved from `var/lib/ssh/config` |
| `iterm` | `.iterm/` (plist + color schemes) | macOS only |
| `bin` | `.local/bin/` (brewup, kubectl-breakout, kubectl-decode) | Moved from `bin/` |
| `misc` | `.hushlogin` | |

## Changes

### 1. Add `stow` to `Brewfile`
- File: `Brewfile`
- Add `brew "stow"`

### 2. Create `stow/` directory with per-tool subdirectories
Move all currently-symlinked files into their respective package directories following the structure above. Each package directory mirrors `$HOME`.

Key moves:
- `.bash_profile`, `.bashrc`, `.zprofile`, `.zshrc`, `.shell/` → `stow/shell/`
- `.gitconfig` → `stow/git/`
- `.vimrc`, `.vim/` → `stow/vim/`
- `.tmux.conf` → `stow/tmux/`
- `.screenrc` → `stow/screen/`
- `var/lib/ssh/config` → `stow/ssh/.ssh/config`
- `.iterm/` → `stow/iterm/`
- `bin/*` → `stow/bin/.local/bin/*`
- `.hushlogin` → `stow/misc/`
- Remove now-empty `var/` and root-level `bin/` directories

### 3. Update `install` script

#### 3a. Add `--migrate` flag and legacy detection

At the top of `install`, parse a `--migrate` flag. Before running stow, detect if old-style symlinks exist (symlinks in `$HOME` pointing directly to `~/.dotfiles/.<file>` at the repo root, not into `stow/`).

Detection logic:
```bash
has_legacy_symlinks() {
    for link in "$HOME"/.*; do
        if [ -L "$link" ]; then
            target="$(readlink "$link")"
            # Old style: points to dotfiles root (e.g. ~/.dotfiles/.bashrc)
            # New style would point into stow/ (e.g. ~/.dotfiles/stow/shell/.bashrc)
            if [[ "$target" == "${SCRIPTPATH}/".*  && "$target" != "${SCRIPTPATH}/stow/"* ]]; then
                return 0
            fi
        fi
    done
    return 1
}
```

Behaviour:
- **No `--migrate`, no legacy symlinks** → fresh install, proceed normally with stow
- **No `--migrate`, legacy symlinks detected** → print message and exit:
  ```
  Legacy (pre-stow) symlinks detected. Run with --migrate to clean up old symlinks and switch to stow.
  ```
- **`--migrate` passed** → clean up old symlinks, then proceed with stow:
  ```bash
  migrate_legacy_symlinks() {
      echo "Removing legacy symlinks..."
      for link in "$HOME"/.*; do
          if [ -L "$link" ]; then
              target="$(readlink "$link")"
              if [[ "$target" == "${SCRIPTPATH}/".*  && "$target" != "${SCRIPTPATH}/stow/"* ]]; then
                  echo "  rm $link (was → $target)"
                  rm "$link"
              fi
          fi
      done
      # Old SSH config symlink
      if [ -L "$HOME/.ssh/config" ]; then
          echo "  rm $HOME/.ssh/config"
          rm "$HOME/.ssh/config"
      fi
      # Old bin/ symlinks
      for link in "$HOME/.local/bin/"*; do
          if [ -L "$link" ] && [[ "$(readlink "$link")" == "${SCRIPTPATH}/bin/"* ]]; then
              echo "  rm $link"
              rm "$link"
          fi
      done
  }
  ```

#### 3b. Replace symlink scripts with stow calls

Where the old `setup_symlinks.sh`, `setup_ssh.sh`, and bin/ loop were called, replace with:

```bash
echo "Symlinking dotfiles with stow"
( umask 077 && mkdir -p "${HOME}/.ssh/config.d" )  # .ssh and config.d created with 700 perms
mkdir -p "${HOME}/.local/bin"       # prevent tree folding — other tools (e.g. Claude) install here too
stow -d "${SCRIPTPATH}/stow" -t "${HOME}" --restow \
    shell git vim tmux screen ssh bin misc

# macOS-only packages:
if [[ $(uname -s) == "Darwin" ]]; then
    stow -d "${SCRIPTPATH}/stow" -t "${HOME}" --restow iterm
fi
```

Notes:
- `--restow` makes re-runs idempotent: it unstows then stows, cleaning up stale symlinks
- `mkdir -p ~/.local/bin` is critical: without it, stow would symlink the entire `.local/bin/` directory to the package, breaking other tools that install there (e.g. Claude Code). Pre-creating the directory forces stow to create individual file symlinks instead.

### 4. Delete obsolete files
- `libexec/setup_symlinks.sh` — replaced by stow
- `libexec/setup_ssh.sh` — SSH config now handled by stow; `mkdir` calls moved to `install`

### 5. Update `CLAUDE.md`
Update architecture section to reflect:
- New `stow/` structure with per-tool packages
- Stow-based symlinking (no exclusion list)
- SSH config location change
- bin scripts location change
- How to add a new package

### 6. Update `.gitignore`
The current `.gitignore` has `.vim/.netrwhist` — update path to `stow/vim/.vim/.netrwhist`.

## Verification

1. **Dry run:** `stow -d ~/.dotfiles/stow -t ~ -n -v shell git vim tmux screen ssh bin misc iterm` — preview without linking
2. **Stow:** Run the full stow command from the updated install script
3. **Check symlinks:**
   - `ls -la ~/.bash_profile` → `~/.dotfiles/stow/shell/.bash_profile`
   - `ls -la ~/.ssh/config` → `~/.dotfiles/stow/ssh/.ssh/config`
   - `ls -la ~/.local/bin/brewup` → `~/.dotfiles/stow/bin/.local/bin/brewup`
   - `ls -la ~/.local/bin/claude` — should still be a real file, NOT a symlink into dotfiles
4. **New shell:** Open a new terminal, verify shell loads correctly
5. **SSH:** Verify `~/.ssh/config` is readable and includes config.d
6. **Shellcheck:** `shellcheck install libexec/*.sh libexec/macos/*.sh stow/bin/.local/bin/*`
7. **Unstow test:** `stow -d ~/.dotfiles/stow -t ~ -D shell` — verify clean removal, then re-stow
