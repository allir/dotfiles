#!/usr/bin/env bash
set -euo pipefail

# This is pretty ugly, but it works on macOS without requiring coreutils for GNU readlink
# Ideally this would be:
# SCRIPT=$( readlink -f ${BASH_SOURCE[0]} )
SCRIPT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )/$( basename "${BASH_SOURCE[0]}" )
SCRIPTPATH=$( dirname "${SCRIPT}" )
KREWFILEPATH=$( realpath "${SCRIPTPATH}/.." )

if ! command -v kubecetl &> /dev/null; then
    echo "kubectl is not installed. Exiting..."
    exit 1
fi

if ! [ ! -d "${HOME}/.krew" ]; then
    echo "Krew is not installed. Exiting..."
    exit 1
fi

if [ ! -d "${KREWFILEPATH}" ]; then
    echo "Krewfile not found. Exiting..."
    exit 1
fi

# Setup Krew Plugins
echo "Installing Krew Plugins"
kubectl krew install < "${KREWFILEPATH}/Krewfile"
