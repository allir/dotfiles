# Environment
source "${HOME}/.shell/profile"

# PATH
source "${HOME}/.shell/path"

# History Management
export HISTFILE="${HOME}/.history"
# share_history implies inc_append_history; unsetting it keeps history sharing
# on read but avoids writing every command immediately to the history file.
setopt share_history
unsetopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
   
export HISTSIZE=100000
export SAVEHIST=1000000
