# Low Severity Fixes

Minor issues — dead code, cosmetic problems, and edge cases that rarely trigger.

---

## 1. `.shell/path` — MANPATH modifications never exported

**File:** `.shell/path:18,22,26,30,34`

**Problem:** `MANPATH` is set but never exported, so `man` in child processes won't see the GNU man pages.

**Steps:**

1. Add `export MANPATH` at the end of the GNU tools section (after line 39)

---

## 2. `.shell/.fzf.bash` and `.shell/.fzf.zsh` — Dead code

**Files:** `.shell/.fzf.bash`, `.shell/.fzf.zsh`

**Problem:** Never sourced. `.bashrc` and `.zshrc` use `source <(fzf --bash/--zsh)` directly.

**Steps:**

1. Delete `.shell/.fzf.bash` and `.shell/.fzf.zsh`

---

## 3. `.vimrc` — `StatuslineGit()` function defined but never used

**File:** `.vimrc:204-211`

**Problem:** `GitBranch()` and `StatuslineGit()` functions are defined but not referenced in the statusline.

**Steps:**

1. Remove the unused functions (lines 204-211)

---

## 4. `.bashrc` / `.zshrc` — Glob fails if `.d` directory exists but is empty

**Files:** `.bashrc:26-29`, `.zshrc:74-77`

**Problem:** Without `nullglob`, an empty directory causes the literal glob string `~/.bashrc.d/*.bashrc` to be passed to `source`, producing an error.

**Steps:**

1. In `.bashrc`, add a file existence check inside the loop:

   ```bash
   if [ -d "${HOME}/.bashrc.d" ]; then
       for file in "${HOME}"/.bashrc.d/*.bashrc; do
           [ -f "$file" ] && source "${file}"
       done
   fi
   ```

2. Apply the same pattern in `.zshrc` for the `.zshrc.d` block

---

## 5. `libexec/macos/configure_trackpad.sh` — Missing shebang

**File:** `libexec/macos/configure_trackpad.sh`

**Problem:** No `#!/usr/bin/env bash` shebang line. Relies on the parent shell's interpreter.

**Steps:**

1. Add `#!/usr/bin/env bash` as the first line of the file

---

## 6. `.shell/commonrc` — `starwars` alias points to offline service

**File:** `.shell/commonrc:8`

**Problem:** `towel.blinkenlights.nl` has been offline for years.

**Steps:**

1. Remove line 8 (`alias starwars='nc towel.blinkenlights.nl 23'`)

---

## 7. `.tmux.conf` — `pbcopy` hardcoded for macOS

**File:** `.tmux.conf:32-39`

**Problem:** Clipboard bindings use `pbcopy` which doesn't exist on Linux.

**Steps:**

1. Wrap each binding with a platform check:

   ```tmux
   if-shell "uname | grep -q Darwin" \
     "bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'" \
     "bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -selection clipboard'"
   ```

---

## 8. `.shell/path` — `go env GOPATH` adds shell startup latency

**File:** `.shell/path:42-44`

**Problem:** `go env GOPATH` spawns a Go process on every shell startup, adding noticeable delay.

**Steps:**

1. Replace with a default that doesn't require running `go`:

   ```bash
   if command -v go &>/dev/null && [[ ! "$PATH" == *${GOPATH:-$HOME/go}/bin* ]]; then
       PATH="${GOPATH:-$HOME/go}/bin:$PATH"
   fi
   ```

---

## 9. `install` — `git pull` can fail with local changes

**File:** `install:32-34`

**Problem:** With `set -e`, a `git pull` failure (e.g. due to local changes) aborts the entire install.

**Steps:**

1. Replace `git pull` with a safer alternative:

   ```bash
   git pull --ff-only || echo "Warning: could not update dotfiles repo (local changes?)"
   ```

---

## 10. `.shell/profile` — `ls`/`grep` aliases defined in profile, not rc

**File:** `.shell/profile:20-24`

**Problem:** These aliases are set in the login profile, not the interactive rc. Non-login bash shells on Linux won't have them.

**Decision:** Keeping these in `.shell/profile` intentionally so all color configuration (CLICOLOR, LSCOLORS, LS_OPTS, GREP_OPTS, LESS) stays co-located in one file.
