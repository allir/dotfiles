#!/usr/bin/env bash
set -euo pipefail

# This is pretty ugly, but it works on macOS without requiring coreutils for GNU readlink
# Ideally this would be:
# SCRIPT=$( readlink -f ${BASH_SOURCE[0]} )
SCRIPT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )/$( basename "${BASH_SOURCE[0]}" )
SCRIPTPATH=$( dirname "${SCRIPT}" )

# Make sure ~/.ssh/ exists and create ~/.ssh/config.d
if [ ! -d "${HOME}/.ssh/config.d" ]; then
    umask 077
    mkdir -p "${HOME}/.ssh/config.d"
fi

# link from dotfiles /var/lib/ssh/config to ~/.ssh/config
ln -snf "$(realpath "${SCRIPTPATH}/../var/lib/ssh/config")" "${HOME}/.ssh/config"
