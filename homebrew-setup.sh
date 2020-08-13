#/usr/bin/env bash
set -euo pipefail

# This is pretty ugly, but it works on macOS without requiring coreutils for GNU readlink
# Ideally this would be:
# SCRIPT=$( readlink -f ${BASH_SOURCE[0]} )
SCRIPT=$( cd "$(dirname ${BASH_SOURCE[0]})" &>/dev/null && pwd )/$( basename ${BASH_SOURCE[0]} )
SCRIPTPATH=$( dirname ${SCRIPT} )

# Setup Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew analytics off

# Install brews/casks
brew bundle --file=${SCRIPTPATH}/Brewfile
