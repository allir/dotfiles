#!/usr/bin/env bash
set -euo pipefail

# This is pretty ugly, but it works on macOS without requiring coreutils for GNU readlink
# Ideally this would be:
# SCRIPT=$( readlink -f ${BASH_SOURCE[0]} )
SCRIPT=$( cd "$(dirname ${BASH_SOURCE[0]})" &>/dev/null && pwd )/$( basename ${BASH_SOURCE[0]} )
SCRIPTPATH=$( dirname ${SCRIPT} )

# Symlink all "dotfiles" with some exeptions
NOLINK=". .. .git .gitignore"
for file in ${SCRIPTPATH}/.*; do
  f=$( basename $file)
  if [[ ! $NOLINK =~ (^|[[:space:]])"$f"($|[[:space:]]) ]]; then
    ln -snf $file ~
  fi
done
