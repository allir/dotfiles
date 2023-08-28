#!/usr/bin/env bash
set -euo pipefail

# This is pretty ugly, but it works on macOS without requiring coreutils for GNU readlink
# Ideally this would be:
# SCRIPT=$( readlink -f ${BASH_SOURCE[0]} )
SCRIPT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )/$( basename "${BASH_SOURCE[0]}" )
SCRIPTPATH=$( dirname "${SCRIPT}" )

# Make sure ~/.ssh/ exists and create ~/.ssh/config.d 
umask 077
mkdir -p ~/.ssh/config.d

ln -snf "${SCRIPTPATH}/.ssh/config" ~/.ssh
