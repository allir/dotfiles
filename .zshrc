# Aliases / Functions
source ~/.shell/alias
source ~/.shell/functions

# Set EMACS mode
set -o emacs

# zsh Completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Fuzzy Find
if command -v fzf &>/dev/null; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# Version Control Info
autoload -Uz vcs_info
autoload -U colors && colors
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}!%f'
zstyle ':vcs_info:git:*' formats "%129F⌥(%f %F{green}%b%f %m%u%c%129F)%f"
zstyle ':vcs_info:git:*' actionformats "%129F⌥(%f %F{green}%b%f %129F|%f %F{red}%a%f %129F)%f"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if ! [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]]; then
    return
  fi

  # Find status on ahead and behind
  if git status -sb | grep -m 1 '^##' &>/dev/null; then
    local gitstatus ahead behind
    gitstatus=$(git status -sb | grep -m 1 '^##')
    ahead=$(echo $gitstatus | grep -o 'ahead [0-9]*' | grep -o '[0-9]*')
    behind=$(echo $gitstatus | grep -m 1 '^##' | grep -o 'behind [0-9]*' | grep -o '[0-9]*')

    if [[ -n $ahead ]]; then
      hook_com[misc]+='%F{green}↑%f'
    fi

    if [[ -n $behind ]]; then
      hook_com[misc]+='%F{red}↓%f'
    fi

    if [[ -n $ahead || -n $behind ]]; then
      hook_com[misc]+=' '
    fi
  fi

  if git status --porcelain | grep -m 1 '^??' &>/dev/null; then
    hook_com[misc]+='%F{red}?%f'
  fi
}

# Prompt
setopt prompt_subst
precmd() {
  vcs_info
}
PROMPT='%(?..%F{red}✘ %?%f'$'\n'')%(!.%F{red}%n%f.%F{cyan}%n%f)@%F{blue}%B%m%b%f:%2~${vcs_info_msg_0_:+ $vcs_info_msg_0_} %# '


# Includes from .zshrc.d 
if [ -d "${HOME}/.zshrc.d" ]; then
  for file in ~/.zshrc.d/*.zshrc; do
    source "${file}"
  done
fi

# Local additions
if [ -r ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
