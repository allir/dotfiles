# Aliases
source ~/.shell/alias
source ~/.shell/functions

# bash Completions
if [ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
fi

# Fuzzy Find
if command -v fzf &>/dev/null; then
    [ -r ~/.fzf.bash ] && source ~/.fzf.bash
fi

# Prompt
## Git Prompt
if [ -r "${HOMEBREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR=${HOMEBREW_PREFIX}/opt/bash-git-prompt/share
    GIT_PROMPT_THEME=Custom
    GIT_PROMPT_THEME_FILE=~/.shell/bash-git-prompt-colors
    source "${HOMEBREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh"
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
