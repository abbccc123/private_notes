#!/bin/bash

# Based on Emmanuel Rouat's .bashrc

[[ $- != *i* ]] && exit

[[ -f /etc/bash.bashrc ]] && . /etc/bash.bashrc

alias   debug="set -o nounset; set -o xtrace"
alias nodebug="set +o nounset; set +o xtrace"

ulimit -S -c0

set -o vi
set -o notify
set -o noclobber

shopt -s cdspell
shopt -s dirspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s huponexit
shopt -s extglob

shopt -u mailwarn


# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White
NC="\e[m"               # Color Reset
ALERT=${BWhite}${On_Red} # Bold White on red background

# @positional param $1: fg color
# @positional param $2: bg color
# @brief: return a terminal escape sequences which can be used to
#+alter the following characters
# NOTE: This is a simple function which only support ANSI basic 8 colors:
# black red green yellow blue magenta cyan white
getClr ()
{
    local -r ARG_COUNT_MIN=1
    local -r ARG_COUNT_MAX=2
    [[ $# -ne $ARG_COUNT_MIN && $# -ne $ARG_COUNT_MAX ]] && {
        echo "Usage: $(basename $0) fg_color [bg_color]"
        return 1
    }

    local -r PATTERN='\\e[${bold}\;${fgColor}\;${bgColor}m'
    local bold=00 fgColor bgColor=49 digit

    [[ $1 =~ '^b' ]] && bold=01

    map () {
        local val
        case $1 in
            *[bB][lL][aA][cC][kK]*)         val=0;;
            *[rR][eE][dD]*)                 val=1;;
            *[gG][rR][eE][eE][nN]*)         val=2;;
            *[yY][eE][lL][lL][oO][wW]*)     val=3;;
            *[yY][eE][lL][lL][oO][wW]*)     val=4;;
            *[mM][aA][gG][eE][nN][tT][aA]*) val=5;;
            *[cC][yY][aA][nN]*)             val=6;;
            *[wW][hH][iI][tT][eE]*)         val=7;;
            *)                              val=*
        esac
        echo "$val"
    }

    digit=`map $1`
    [[ $digit != \* ]] && fgColor=3${digit} || fgColor=30

    [[ $# -eq 2 ]] && {
        digit=`map $2`
        [[ $digit != \* ]] && bgColor=4${digit}
    }

    eval echo "$PATTERN"
}

######################################################## motd
echo -e "${BCyan}BASH ${BRed}${BASH_VERSION%.*}${BCyan}\
 - DISPLAY on ${BRed}$DISPLAY${NC}\n"
date
type -t fortune |& grep file &>/dev/null && {
    fortune -s
} || {
    echo -e "${Yellow}It seems that you have not\
installed fortune, why not?${NC}"
}
########################################################

###################################################################### Prompt
if [[ -n ${SSH_CONNECTION} ]]; then
    conn_color=${Green}
elif [[ "${DISPLAY%%:0*}" != "" ]]; then
    conn_color=${ALERT}
else
    conn_color=${BCyan}
fi

if [[ ${USER} == "root" ]]; then
    user_color=${Red/0/4}
elif [[ ${USER} != $(logname) ]]; then
    user_color=${BRed/1/4}
else
    user_color=${BCyan/1/4}
fi

# Get appropriate color regarding to cpu load
load_color ()
{
    local n_cpu s_load m_load l_load sysload

    n_cpu=`grep -c 'processor' /proc/cpuinfo`
    s_load=$(( 100 * ${n_cpu} ))
    m_load=$(( 150 * ${n_cpu} ))
    l_load=$(( 200 * ${n_cpu} ))

    sysload=`cut -d' ' -f1 /proc/loadavg | tr -d '.'`
    sysload=$(( 10#$sysload ))

    if      (( sysload > l_load )); then
        echo -ne ${ALERT}
    elif    (( sysload > m_load )); then
        echo -ne ${Red}
    elif    (( sysload > s_load )); then
        echo -ne ${Yellow}
    else
        echo -ne ${Blue}
    fi
}

disk_color ()
{
    if [ ! -w "${PWD}" ] ; then
        echo -en ${Red}
    elif [ -s "${PWD}" ] ; then
        local used=$(command df -P "$PWD" |
                   awk 'END {print $5} {sub(/%/,"")}')
        if      (( used > 95 )); then
            echo -en ${ALERT}
        elif    (( used > 90 )); then
            echo -en ${BRed}
        else
            echo -en ${Green}
        fi
    else
        echo -en ${Cyan}
    fi
}

job_color ()
{
    if      (( $(jobs -s | wc -l) > 0 )); then
        echo -en ${BRed}
    elif    (( $(jobs -r | wc -l) > 0 )) ; then
        echo -en ${BCyan}
    fi
}

append_path ()
{
    case :"$PATH": in
        *:"$1":* ) ;;
        *        ) PATH="${PATH:+$PATH:}$1";;
    esac
}

command_not_found_handle ()
{
    echo -e "Command [${ALERT}$1${NC}] not found, sorry for that"
}

[[ -z $SSH_CONNECTION ]] && host_str='\h' ||
    host_str=`echo $SSH_CONNECTION | awk '{print $3}'`

PROMPT_COMMAND="history -a"
PS1="[\[\$(load_color)\]\A\[${NC}\] "
PS1=${PS1}"\[${user_color}\]\u\[${NC}\]@\[${conn_color}\]$host_str\[${NC}\] "
PS1=${PS1}"\[\$(disk_color)\]\W\[${NC}\]] "
PS1=${PS1}"\[\$(job_color)\]>\[${NC}\] "
######################################################################

################################################# alias
alias du='du -kh'
alias df='df -kTh'
alias ls='ls -F --color=auto'
alias grep='grep -i --color=auto'
alias ..='cd ..'
alias cd..='cd ..'
alias rm="rm -i"
alias psme="ps u -u $USER | grep -v 'grep'"
alias ll="ls -l"
alias lsblk="lsblk -f"

alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
#################################################

################################################################ functions
unalias echo &>/dev/null
echo ()
{
    [[ ! -t 1 ]] && [[ $BASH_SUBSHELL -eq 0 ]] && return

    builtin echo "$@"
}

unalias rm &>/dev/null
rm ()
{
    OPTIND=1
    b_force_opt=
    while getopts ":f" opt; do
        [[ $opt = f ]] && b_force_opt=1
    done
    [[ $b_force_opt = 1 ]] &&
    { echo -e "${ALERT}Force removing?${NC} [Y/n]" && read -n1 -s; } &&
        [[ $REPLY != y ]] && {
            echo "Cancelled"; return
        }
    command rm "$@"
}

ff ()
{
    find -type f -iname "*${*}*" -ls
}

ps ()
{
    command ps "$@" -u $USER -o pid,pgid,%cpu,%mem,rss,cmd
}

man ()
{
    col=$(($COLUMNS-10))
    (($col > 80)) && col=80
    echo "Use width = $col" ; sleep 1
    COLUMNS=$col command -p man "$@"
}

vim ()
{
    TERM=xterm-256color command vim -u ~/.vimrc "$@"
}
################################################################

mesg n # disable annoying!

################################Readline customize
prefix='bind -m vi-insert'
comms=(
    '"\C-b": "\e"'
    '"\C-l": backward-kill-word'
    '"\ei": complete'
)

for comm in "${comms[@]}"; do
    eval "$prefix" \'"$comm"\'
done
################################

# Npm completion patch
type npm &>/dev/null && . <( npm completion )

##################################################### Less customize
alias more='less'
export PAGER=less
export LESSCHARSET='utf-8'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
                # Use this if lesspipe.sh exists.
export LESS='-i -N -w  -z-4 -g -M -X -R -F -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
#####################################################

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"
export HISTTIMEFORMAT="$(echo -e ${BCyan})[%d/%m %H:%M:%S]$(echo -e ${NC}) "
export HISTCONTROL=ignoredups
export HOSTFILE=$HOME/.hosts    # Put a list of remote hosts in ~/.hosts

##########################################################
append_path "$HOME/bin"
append_path "$HOME/.local/bin"
append_path "/home/abbccc/venv/bin"
append_path "/home/abbccc/.local/share/gem/ruby/3.0.0/bin"
##########################################################

export PYTHONPATH=$HOME/venv/lib/python3.11/site-packages:$PYTHONPATH

#################################################################### V2ray service
type v2ray &>/dev/null && ! pgrep v2ray &>/dev/null && {
    v2ray run -c $HOME/Proxy/v2.json&>/dev/null&
    jobs
    sleep 1 && ps $! &>/dev/null && echo "V2ray service is running."
}
####################################################################

export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export INPUT_METHOD=fcitx5
export SDL_IM_MODULE=fcitx5
export GLFW_IM_MODULE=ibus

export HISTSIZE=2000
