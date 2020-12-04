# Aliases
source ~/.shell/.alias

# bash Completions
[ -r '/usr/local/etc/profile.d/bash_completion.sh' ] && source '/usr/local/etc/profile.d/bash_completion.sh'

# Fuzzy Find
if [ "$OS" == "Darwin" ]; then
  [ -r ~/.fzf.bash ] && source ~/.fzf.bash
fi

# Prompt
### Git Prompt
if [ -r '/usr/local/opt/bash-git-prompt/share/gitprompt.sh' ]; then
  __GIT_PROMPT_DIR=/usr/local/opt/bash-git-prompt/share
  GIT_PROMPT_THEME=Custom
  GIT_PROMPT_THEME_FILE=~/.git-prompt/git-prompt-colors
  source '/usr/local/opt/bash-git-prompt/share/gitprompt.sh'
fi
