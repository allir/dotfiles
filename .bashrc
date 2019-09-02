# Aliases
alias ll='ls -l'
alias lt='du -sh * | sort -h'
alias left='ls -t -1'
alias grep='grep --color=auto'
alias d='docker'
alias k='kubectl'
alias cat='bat --style=plain --paging=never'
alias ping='prettyping --nolegend'
alias myip='dig @resolver1.opendns.com ANY myip.opendns.com +short'
alias cpv='rsync -ah --info=progress2'
alias trash='mv --force -t ~/.Trash '
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
alias cdgit='cd `git rev-parse --show-toplevel`'
alias starwars='nc towel.blinkenlights.nl 23'
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

# bash Completions
[[ -r '/usr/local/etc/profile.d/bash_completion.sh' ]] && source '/usr/local/etc/profile.d/bash_completion.sh'

# Fuzzy Find
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Git Prompt
if [ -f '/usr/local/opt/bash-git-prompt/share/gitprompt.sh' ]; then
  __GIT_PROMPT_DIR=/usr/local/opt/bash-git-prompt/share
  GIT_PROMPT_THEME=Custom
  GIT_PROMPT_THEME_FILE=~/.git-prompt/git-prompt-colors
  source '/usr/local/opt/bash-git-prompt/share/gitprompt.sh'
fi
