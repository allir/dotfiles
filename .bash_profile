# General
export OWNER='Aðalsteinn Rúnarsson'
export LANG=en_US.UTF-8

# MacOS/BSD CLI Colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# History Management
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=20000
export HISTSIZE=20000
PROMPT_COMMAND='history -a; history -c; history -r'
tac "$HISTFILE" | awk '!x[$0]++' > /tmp/history && tac /tmp/history > "$HISTFILE" && rm /tmp/history

# Use GNU Tools over BSD
#PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
#PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
#MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
MANPATH="/usr/local/opt/gnu-getopt/libexec/gnuman:$MANPATH"

# Display Archey if installed
if command -v archey &>/dev/null; then
	archey
fi

# Source .bashrc
if [ -e $HOME/.bashrc ]; then
  source $HOME/.bashrc
fi
