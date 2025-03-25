#!/usr/bin/env bash
set -euo pipefail

# This is pretty ugly, but it works on macOS without requiring coreutils for GNU readlink
# Ideally this would be:
# SCRIPT=$( readlink -f ${BASH_SOURCE[0]} )
SCRIPT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )/$( basename "${BASH_SOURCE[0]}" )
SCRIPTPATH=$( dirname "${SCRIPT}" )
PROFILEPATH=$( realpath "${SCRIPTPATH}/../../var/lib/terminal/allir.terminal" )

#osascript "${SCRIPTPATH}/configure_terminal.scpt" "${PROFILEPATH}"
open "${PROFILEPATH}"

defaults write com.apple.Terminal "Default Window Settings" -string "allir"
defaults write com.apple.Terminal "Startup Window Settings" -string "allir"

killall Terminal
