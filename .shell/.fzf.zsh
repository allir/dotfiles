# Setup fzf
# ---------
case $(uname -s) in
    "Darwin" )
        if [[ ! "$PATH" == *$HOMEBREW_PREFIX/opt/fzf/bin* ]]; then
          export PATH="$HOMEBREW_PREFIX/opt/fzf/bin:$PATH"
        fi
        # Auto-completion
        # ---------------
        [[ $- == *i* ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
        # Key bindings
        # ------------
        source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
        ;;
  
    "Linux" )
        # Auto-completion
        # ---------------
        [[ $- == *i* ]] && source "/usr/share/doc/fzf/examples/completion.zsh" 2> /dev/null
        # Key bindings
        # ------------
        source "/usr/share/doc/fzf/examples/key-bindings.zsh"
        ;;
esac
