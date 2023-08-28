# Environment
source ~/.shell/env

# PATH
source ~/.shell/path

# History Management
export SHELL_SESSION_HISTORY=0
export HISTFILE=~/.history
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=25000
export HISTFILESIZE=25000
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$';'}history -a; history -c; history -r"

# Source .bashrc
if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi
