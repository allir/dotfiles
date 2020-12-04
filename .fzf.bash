# Setup fzf
# ---------
## on macOS add zfz to the PATH
if [ `uname -s` == "Darwin" ] && [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
case `uname -s` in
  "Darwin" )
    [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null
    ;;
  "Linux" )
    [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null
    ;;
esac

# Key bindings
# ------------
case `uname -s` in
  "Darwin" )
    source "/usr/local/opt/fzf/shell/key-bindings.bash"
    ;;
  "Linux" )
    source "/usr/share/doc/fzf/examples/key-bindings.bash"
    ;;
esac
