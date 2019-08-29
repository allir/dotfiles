# Aliases
alias ll='ls -l'
alias grep='grep --color=auto'
alias d='docker'
alias k='kubectl'
alias cat='bat --style=plain --paging=never'
alias ping='prettyping --nolegend'
alias myip='dig @resolver1.opendns.com ANY myip.opendns.com +short'


# bash Completions
[[ -r '/usr/local/etc/profile.d/bash_completion.sh' ]] && source '/usr/local/etc/profile.d/bash_completion.sh'

# Fuzzy Find
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Git Prompt
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  GIT_PROMPT_THEME=Custom
  GIT_PROMPT_THEME_FILE=~/.git-prompt/git-prompt-colors
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi
