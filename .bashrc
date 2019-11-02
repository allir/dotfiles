# Aliases
alias ll='ls -l'
alias lt='du -sh * | sort -h'
alias left='ls -t -1'
alias grep='grep --color=auto'
alias cat='bat --style=plain --paging=never'
alias ping='prettyping --nolegend'
alias myip='dig @resolver1.opendns.com ANY myip.opendns.com +short'
alias cpv='rsync -ah --info=progress2'
alias trash='mv --force -t ~/.Trash '
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
alias cdgit='cd `git rev-parse --show-toplevel`'
alias starwars='nc towel.blinkenlights.nl 23'

# Python
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

# Docker/Kubernetes
kube(){
  export KUBECONFIG=~/.kube/configs/${1}
}
kubedecode(){
  kubectl get secret -o json $* | jq -r '.data | map_values(@base64d)'
}
alias d='docker'
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kl='kubectl logs'

## Prunes all duplicates from history
history_prune(){
  tac "$HISTFILE" | awk '!x[$0]++' > /tmp/history && tac /tmp/history > "$HISTFILE" && rm /tmp/history
}

# bash Completions
[[ -r '/usr/local/etc/profile.d/bash_completion.sh' ]] && source '/usr/local/etc/profile.d/bash_completion.sh'

# Fuzzy Find
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Prompt
### Git Prompt
if [ -f '/usr/local/opt/bash-git-prompt/share/gitprompt.sh' ]; then
  __GIT_PROMPT_DIR=/usr/local/opt/bash-git-prompt/share
  GIT_PROMPT_THEME=Custom
  GIT_PROMPT_THEME_FILE=~/.git-prompt/git-prompt-colors
  source '/usr/local/opt/bash-git-prompt/share/gitprompt.sh'
fi
