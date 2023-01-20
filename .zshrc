# Aliases
source ~/.shell/alias

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

# Prompt
if [ -r "$HOMEBREW_PREFIX/opt/gitstatus/gitstatus.prompt.zsh" ];then
  source "$HOMEBREW_PREFIX/opt/gitstatus/gitstatus.prompt.zsh"
  PROMPT='%(?..%F{red}✘ %?%f'$'\n'')%(!.%F{red}%n%f.%F{cyan}%n%f)@%F{blue}%B%m%b%f:%2~${GITSTATUS_PROMPT:+ %129F⌥(%f$GITSTATUS_PROMPT%129F)%f} %# '
else
  PROMPT='%(?..%F{red}✘ %?%f'$'\n'')%(!.%F{red}%n%f.%F{cyan}%n%f)@%F{blue}%B%m%b%f:%2~ %# '
fi

# Includes from .zshrc.d 
if [ -d ${HOME}/.zshrc.d ]; then
  for file in ~/.zshrc.d/*.zshrc; do
    source "${file}"
  done
fi

# Local additions
if [ -r ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
