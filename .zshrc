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
PROMPT='%(?.%F{green}✔%f.%F{red}✘ %?%f) %(!.%F{red}%n%f.%F{cyan}%n%f)@%F{blue}%B%m%b%f:%2~ %# '

# Local additions
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
