# Environment
source "${HOME}/.shell/profile"

# PATH
source "${HOME}/.shell/path"

# History Management
export HISTFILE="${HOME}/.history"
setopt share_history
unsetopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
   
export HISTSIZE=100000
export HISTFILESIZE=1000000
