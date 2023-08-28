# Aliases
source ~/.shell/alias
source ~/.shell/functions

# bash Completions
if [ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]; then
    source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

# Fuzzy Find
if command -v fzf &>/dev/null; then
    [ -r ~/.fzf.bash ] && source ~/.fzf.bash
fi

# Prompt
if [ -r "$HOMEBREW_PREFIX/opt/gitstatus/gitstatus.prompt.zsh" ];then
    source "$HOMEBREW_PREFIX/opt/gitstatus/gitstatus.prompt.sh"
    # gitstatus overwrites the PROMPT_COMMAND set earlier
    PROMPT_COMMAND='history -a; history -c; history -r;gitstatus_prompt_update'
    PS1='\[\e[0;36m\]\u\[\e[0m\]@\[\e[0;34m\]\h\[\e[0m\] \w${GITSTATUS_PROMPT:+ \[\e[0;35m\]⌥(\[\e[0m\]$GITSTATUS_PROMPT\[\e[0;35m\])\[\e[0m\]} \$ '
else
    PS1='\[\e[0;36m\]\u\[\e[0m\]@\e[0;34m\]\h\[\e[0m\] \w \$ '
fi

# Includes from .bashrc.d 
if [ -d "${HOME}/.bashrc.d" ]; then
    for file in ~/.bashrc.d/*.bashrc; do
        source "${file}"
    done
fi

# Local additions
if [ -r ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
