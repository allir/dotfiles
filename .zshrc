# Aliases
source ~/.shell/.alias

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
