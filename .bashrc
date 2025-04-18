#
# ~/.bashrc
#

set -o vi # Enable vi hotkeys in interactive shell.
echo '''
+-------------------------+
|stay calm, keep organized|
+-------------------------+
Keep fitting every day!
'''

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ..='cd ..'
alias cd..='cd ..'
alias grep='grep -i --color'
PS1='\[\033[01;33m\][\u@\h \w]$> \[\033[01;36m\]'

alias rm="rm -i"
alias psme="ps u -u $USER | grep -v 'grep'"
alias ll="ls -l"

export PATH=/home/abbccc/venv/bin:$PATH
export PATH=/home/abbccc/.local/share/gem/ruby/3.0.0/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH

export PYTHONPATH=$HOME/venv/lib/python3.11/site-packages:$PYTHONPATH

neofetch

# LFS experiment
export LFS=/mnt/LFS

echo $BASH_SOURCE

detail()
{
    if [ -z "$1" -o $# -ne 1 ]; then
	echo "Bad usage"
	return
    fi
    prg_name="$1"
    prg_path=`which $prg_name 2>/dev/null`

    if [ $? -ne 0 ]; then
	echo "Command not found"
	return
    fi

    realpath $prg_path
    echo
    file $prg_path
    echo
    whatis $prg_name
    echo
    type $prg_name
    echo
}

mesg n # disable annoying!
