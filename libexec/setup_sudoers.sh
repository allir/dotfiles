#!/usr/bin/env bash
set -euo pipefail

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

SDPATH="/etc/sudoers.d"
if [[ $(uname -s) == "Darwin" ]]; then
    SDPATH="/private${SDPATH}"
fi

if [ ! -d "${SDPATH}/$(whoami)" ]; then
    # Add sudoers file for current user
    cat <<EOF | sudo tee "${SDPATH}/$(whoami)" > /dev/null
$(whoami) ALL=(ALL) NOPASSWD: ALL
EOF

    # Set permissions
    sudo chmod 440 "/private/etc/sudoers.d/$(whoami)"
    
    # Validate file
    sudo visudo -cf "${SDPATH}/$(whoami)" > /dev/null
fi
