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
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:git:*' formats "%129F⌥(%f%{$fg[green]%}%b%{$reset_color%}%129F)%f%m%u%c"
zstyle ':vcs_info:git:*' actionformats "%129F⌥(%f%{$fg[green]%}%b%{$reset_color%}%129F|%f%{$fg[red]%}%a%{$reset_color%}%129F)%f%m%u%c"

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
