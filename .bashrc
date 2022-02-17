# Aliases
source ~/.shell/alias

# bash Completions
if [ -r '/usr/local/etc/profile.d/bash_completion.sh' ]; then
  source '/usr/local/etc/profile.d/bash_completion.sh'
fi

# Fuzzy Find
if command -v fzf &>/dev/null; then
  [ -r ~/.fzf.bash ] && source ~/.fzf.bash
fi

# Prompt
if [ -r /usr/local/opt/gitstatus/gitstatus.prompt.zsh ];then
  source /usr/local/opt/gitstatus/gitstatus.prompt.sh
  # gitstatus overwrites the PROMPT_COMMAND set earlier
  PROMPT_COMMAND='history -a; history -c; history -r;gitstatus_prompt_update'
  PS1='\e[0;36m\u\e[0m@\e[0;34m\h\e[0m \w${GITSTATUS_PROMPT:+ \e[0;35m⌥(\e[0m$GITSTATUS_PROMPT\e[0;35m)\e[0m} \$ '
else
  PS1='\e[0;36m\u\e[0m@\e[0;34m\h\e[0m \w \$ '
fi

# Local additions
if [ -r ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi
