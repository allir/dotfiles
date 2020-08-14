# Environment
source ~/.shell/.env

# Display Archey if installed
if command -v archey &>/dev/null; then
	archey
fi

# Source .bashrc
if [ -e $HOME/.bashrc ]; then
  source $HOME/.bashrc
fi
