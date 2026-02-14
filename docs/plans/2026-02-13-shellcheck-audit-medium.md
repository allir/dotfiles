# Medium Severity Fixes

Correctness and robustness issues that cause errors or unexpected behavior in certain conditions.

---

## 1. `.shell/path` — Homebrew shellenv uses `&&` instead of `||`

Already fixed as part of high-severity fix #3 (commit `8891a15`).

---

## 2. `.bashrc` — `brew --prefix` called without guard

**File:** `.bashrc:6`

**Problem:** On systems without Homebrew, `brew --prefix` prints "command not found" to stderr on every bash shell start. Compare with `.zshrc:11` which properly guards with `if type brew &>/dev/null`.

**Steps:**

1. Wrap the bash completion line in a `command -v brew` guard:

   ```bash
   if command -v brew &>/dev/null; then
       [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ] && source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
   fi
   ```

---

## 3. `.shell/commonrc` — `history-prune` uses predictable temp file

**File:** `.shell/commonrc:33-35`

**Problem:** Uses the fixed path `/tmp/history` which is a symlink-attack vector. Also doesn't work correctly with zsh's extended history format (timestamps make every entry unique).

**Steps:**

1. Replace with `mktemp` and a safer pipeline:

   ```bash
   history-prune(){
       local tmpfile
       tmpfile=$(mktemp) || return 1
       tac "$HISTFILE" | awk '!x[$0]++' | tac > "$tmpfile" && mv "$tmpfile" "$HISTFILE" || rm -f "$tmpfile"
   }
   ```

---

## 4. `.zprofile` — Add comment explaining `share_history` / `inc_append_history` interaction

**File:** `.zprofile:9-10`

**Background:** `share_history` implies `inc_append_history`. Unsetting it partially changes sharing behavior. This is intentional — keep both lines but add a comment explaining why.

**Steps:**

1. Add a comment above the two lines:

   ```bash
   # share_history implies inc_append_history; unsetting it keeps history sharing
   # on read but avoids writing every command immediately to the history file.
   setopt share_history
   unsetopt inc_append_history
   ```

---

## 5. `libexec/setup_krew_plugins.sh` — Wrong existence check

**File:** `libexec/setup_krew_plugins.sh:21-24`

**Problem:** Tests `-d` on `KREWFILEPATH` (the repo root directory, which always exists) instead of checking if the Krewfile itself exists.

**Steps:**

1. Change `-d "${KREWFILEPATH}"` to `-f "${KREWFILEPATH}/Krewfile"`

---

## 6. `libexec/setup_homebrew.sh` — Deprecated Homebrew install URL

**File:** `libexec/setup_homebrew.sh:12`

**Problem:** Uses `master` branch URL. Homebrew moved the default branch to `HEAD`.

**Steps:**

1. Replace `master` with `HEAD` in the curl URL

---

## 7. `install` + `remote_install` — Xcode-select wait loop re-requests install

**Files:** `install:20-28`, `remote_install:13-21`

**Problem:** The loop calls `xcode-select --install` every second instead of checking if the tools are installed. `xcode-select -p` only prints the configured path without validating the tools are actually present. Instead, check for a known file installed by CLT, matching the approach used by Homebrew's own installer.

**Steps:**

1. Replace the loop with a file existence check:

   ```bash
   if ! [[ -e "/Library/Developer/CommandLineTools/usr/bin/git" ]]; then
     xcode-select --install 2>/dev/null || true
     echo "Waiting for xcode command line tools installation to finish..."
     until [[ -e "/Library/Developer/CommandLineTools/usr/bin/git" ]]; do
       sleep 5
     done
   fi
   ```

2. Apply the same change to `remote_install`
