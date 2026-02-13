#!/usr/bin/env bash
set -euo pipefail

# This is pretty ugly, but it works on macOS without requiring coreutils for GNU readlink
# Ideally this would be:
# SCRIPT=$( readlink -f ${BASH_SOURCE[0]} )
SCRIPT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )/$( basename "${BASH_SOURCE[0]}" )
SCRIPTPATH=$( dirname "${SCRIPT}" )
DOTFILES_PATH=$(realpath "${SCRIPTPATH}/..")

# Symlink all "dotfiles" with some exeptions
NOLINK=". .. .git .gitignore .claude"
echo "Symlinking dotfiles from ${DOTFILES_PATH}"
for file in "${DOTFILES_PATH}"/.*; do
  f=$( basename "$file")
  if [[ ! $NOLINK =~ (^|[[:space:]])"$f"($|[[:space:]]) ]]; then
    echo "ln -snf $file ${HOME}/"
    ln -snf "$file" "${HOME}/"
  fi
done
