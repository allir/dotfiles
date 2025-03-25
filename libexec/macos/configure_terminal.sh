#!/usr/bin/env bash
set -euo pipefail

# This is pretty ugly, but it works on macOS without requiring coreutils for GNU readlink
# Ideally this would be:
# SCRIPT=$( readlink -f ${BASH_SOURCE[0]} )
SCRIPT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )/$( basename "${BASH_SOURCE[0]}" )
SCRIPTPATH=$( dirname "${SCRIPT}" )
PROFILEPATH=$( realpath "${SCRIPTPATH}/../../var/lib/terminal/allir.terminal" )

#osascript "${SCRIPTPATH}/configure_terminal.scpt" "${PROFILEPATH}"
echo "Importing Terminal profile, this will open a new Terminal window"
sleep 1
open "${PROFILEPATH}"

echo "Setting the default profile in Terminal"
defaults write com.apple.Terminal "Default Window Settings" -string "allir"
defaults write com.apple.Terminal "Startup Window Settings" -string "allir"

echo "This will close all Terminal windows afterwards, to cancel press Ctrl+C"
echo "Continuing in 5 seconds..."
sleep 5
killall Terminal
