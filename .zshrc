# Aliases
source ~/.shell/.alias

# zsh Completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Fuzzy Find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
