# High Severity Fixes

Issues that were likely causing problems right now.

---

## 1. Zsh history persistence broken — missing `SAVEHIST`

**File:** `.zprofile:16`

**Problem:** `HISTFILESIZE` is a bash-only variable. Zsh requires `SAVEHIST` to control how many lines are written to the history file. Without it, zsh uses a small default (typically 0 or 1000), meaning most history is lost between sessions.

**Steps:**

1. Replace `export HISTFILESIZE=1000000` with `export SAVEHIST=1000000`

---

## 2. `gnu-getopt` never added to PATH — wrong directory check

**File:** `.shell/path:36-39`

**Problem:** The block checked `[ -d "${HOMEBREW_PREFIX}/opt/gnu-getopt/libexec" ]` but Homebrew's `gnu-getopt` installs to `bin/` directly — there is no `libexec` directory. The guard condition also checked for `gnubin` in PATH while adding `/bin`. The MANPATH referenced a nonexistent `libexec/gnuman`.

**Steps:**

1. Change the directory check from `libexec` to `bin`
2. Fix the PATH duplicate guard to check for `bin` not `gnubin`
3. Fix the MANPATH to `share/man` instead of `libexec/gnuman`

---

## 3. Homebrew path detection broken on Intel Macs

**Files:** `.shell/path:11-13`, `install:43`, `libexec/setup_homebrew.sh:13`

**Problem:** `.shell/path` used `||` with `&&` chaining that short-circuited on Intel Macs. `install` and `setup_homebrew.sh` hardcoded the Apple Silicon path only.

**Steps:**

1. Replace all three locations with a consistent `if/elif` pattern:

   ```bash
   if [ -f /opt/homebrew/bin/brew ]; then
       eval "$(/opt/homebrew/bin/brew shellenv)"
   elif [ -f /usr/local/bin/brew ]; then
       eval "$(/usr/local/bin/brew shellenv)"
   fi
   ```
