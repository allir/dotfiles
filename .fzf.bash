# Setup fzf
# ---------
## on macOS add zfz to the PATH
if [[ `uname -s` == "Darwin" ]] && [[ ! "$PATH" == *$HOMEBREW_PREFIX/opt/fzf/bin* ]]; then
  export PATH="$HOMEBREW_PREFIX/opt/fzf/bin:$PATH"
fi

# Auto-completion & Key bindings
# ---------------
case `uname -s` in
  "Darwin" )
    [[ $- == *i* ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.bash" 2> /dev/null
    source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.bash"
    ;;
  "Linux" )
    [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null
    source "/usr/share/doc/fzf/examples/key-bindings.bash"
    ;;
esac
