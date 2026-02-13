# Environment
source "${HOME}/.shell/profile"

# PATH
source "${HOME}/.shell/path"

# History Management
export SHELL_SESSION_HISTORY=0
export HISTFILE=${HOME}/.history
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=1000000
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$';'}history -a; history -c; history -r"

# Source .bashrc
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi
