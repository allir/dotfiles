# Setup fzf
# ---------
case `uname -s` in
  "Darwin" )
    if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
      export PATH="$PATH:/usr/local/opt/fzf/bin"
    fi
    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
    # Key bindings
    # ------------
    source "/usr/local/opt/fzf/shell/key-bindings.zsh"
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
