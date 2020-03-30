# Aliases
alias ll='ls -l'
alias lt='du -sh * | sort -h'
alias left='ls -t -1'
alias depth="find . -type d | awk -F\"/\" 'NF > max {max = NF-1} END {print max}'"
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

# Git
git-prune(){
  git branch -vv | grep origin | grep gone | awk '{print $1}'|xargs -L 1 git branch -D
}

# Docker/Kubernetes
kube(){
  export KUBECONFIG=~/.kube/configs/${1}
}
kubedecode(){
  kubectl get secret -o json $* | jq -r '.data | map_values(@base64d)'
}
daemoncat(){
  kubectl exec -ti -n daemoncat $* -- nsenter -t 1 -m -i -n -u bash
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
[ -r '/usr/local/etc/profile.d/bash_completion.sh' ] && source '/usr/local/etc/profile.d/bash_completion.sh'

# Fuzzy Find
[ -r ~/.fzf.bash ] && source ~/.fzf.bash

# Prompt
### Git Prompt
if [ -r '/usr/local/opt/bash-git-prompt/share/gitprompt.sh' ]; then
  __GIT_PROMPT_DIR=/usr/local/opt/bash-git-prompt/share
  GIT_PROMPT_THEME=Custom
  GIT_PROMPT_THEME_FILE=~/.git-prompt/git-prompt-colors
  source '/usr/local/opt/bash-git-prompt/share/gitprompt.sh'
fi
