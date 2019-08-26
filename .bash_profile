export OWNER='Aðalsteinn Rúnarsson'
export LANG=en_US.UTF-8
#export LANG=is_IS.UTF-8

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
#export LS_COLORS="ow=01;90:di=01;90"

export HISTFILESIZE=10000
export HISTSIZE=10000
PROMPT_COMMAND='history -a; history -c; history -r'

#PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

if which -s archey; then
	archey
fi

if [ -f $HOME/.bashrc ]; then
  source $HOME/.bashrc
fi
