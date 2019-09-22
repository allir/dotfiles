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
  export KUBECONFIG=~/.kube/${1}
}
alias d='docker'
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'

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

# Kube PS1
if [ -f '/usr/local/opt/kube-ps1/share/kube-ps1.sh' ]; then
  KUBE_PS1_PREFIX=''
  KUBE_PS1_SUFFIX=''
  KUBE_PS1_SEPARATOR='| '
  KUBE_PS1_SYMBOL_COLOR=blue
  KUBE_PS1_CTX_COLOR=blue
  KUBE_PS1_NS_COLOR=cyan
  source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
  kubeoff -g
  # Note: because of bash-git-prompt setting the PS1 variable doesn't work as it will override it with a PROMPT COMMAND. Instead we add it to the prompt command.
  #PS1="$(kube_ps1)\n${PS1}
  PROMPT_COMMAND="$(echo $PROMPT_COMMAND | sed 's/_kube_ps1_update_cache;/_kube_ps1_update_cache;kube_ps1;/g')"
fi
