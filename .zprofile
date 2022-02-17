# Environment
source ~/.shell/env

# PATH
source ~/.shell/path

# History Management
export HISTFILE=~/.history
setopt share_history
unsetopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
   
export HISTSIZE=25000
export HISTFILESIZE=25000
