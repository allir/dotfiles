# shellcheck disable=SC2034,SC1090,SC1091
# Aliases / Functions
source "${HOME}/.shell/commonrc"

# bash Completions
if command -v brew &>/dev/null; then
    [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ] && source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

# Fuzzy Find
if command -v fzf &>/dev/null; then
    source <(fzf --bash)
fi

# Prompt
## Git Prompt
if [ -r "${HOMEBREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR=${HOMEBREW_PREFIX}/opt/bash-git-prompt/share
    GIT_PROMPT_THEME=Custom
    GIT_PROMPT_THEME_FILE="${HOME}/.shell/bash-git-prompt-colors"
    source "${HOMEBREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh"
else
    PS1='\[\e[0;36m\]\u\[\e[0m\]@\e[0;34m\]\h\[\e[0m\] \w \$ '
fi


# Includes from .bashrc.d 
if [ -d "${HOME}/.bashrc.d" ]; then
    for file in "${HOME}"/.bashrc.d/*.bashrc; do
        [ -f "$file" ] && source "${file}"
    done
fi
