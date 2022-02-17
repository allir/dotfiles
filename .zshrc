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
if [ -r /usr/local/opt/gitstatus/gitstatus.prompt.zsh ];then
  source /usr/local/opt/gitstatus/gitstatus.prompt.zsh
  PROMPT='%(?..%F{red}✘ %?%f'$'\n'')%(!.%F{red}%n%f.%F{cyan}%n%f)@%F{blue}%B%m%b%f:%2~${GITSTATUS_PROMPT:+ %129F⌥(%f$GITSTATUS_PROMPT%129F)%f} %# '
else
  PROMPT='%(?..%F{red}✘ %?%f'$'\n'')%(!.%F{red}%n%f.%F{cyan}%n%f)@%F{blue}%B%m%b%f:%2~ %# '
fi

# Local additions
if [ -r ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
