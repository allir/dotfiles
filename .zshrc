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
source "/usr/local/opt/zsh-git-prompt/zshrc.sh"
PROMPT='%F{cyan}%n%f@%F{blue}%B%m%b%f:%2~ %# '

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
