#!/bin/bash
## written by 12ants.github.io
#########################
## -- CUSTOM LINUX --  ##
#########################
##
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
## ADDING COLOR-CODES -- (Need to run inside other command.)
export bold=$(tput bold) dim=$(tput dim) so=$(tput smso) noso=$(tput rmso) rev=$(tput rev) re=$(tput sgr0) normal=$(tput sgr0) \
redb=$(tput setab 1) greenb=$(tput setab 2) yellowb=$(tput setab 3) blueb=$(tput setab 4) purpleb=$(tput setab 5) cyanb=$(tput setab 6) \
grayb=$(tput setab 7) red=$(tput setaf 1) green=$(tput setaf 2) yellow=$(tput setaf 3) blue=$(tput setaf 4) purple=$(tput setaf 5) \
cyan=$(tput setaf 6) gray=$(tput setaf 7) white=$(tput setaf 7 bold) pink=$(tput setaf 5 bold) darkblue=$(tput setab 5 bold) blink=$(tput blink) \
left2=$(tput cub 2) up1=$(tput cuu1) c75=$(echo "  ---------------------------------------------------------------------------"); clear; echo ; c2="$cyan --$re";
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi




alias loginscreen='
read -n1 -ep "  --  "$gray$dim"Choose default login screen, "$re"["$green"G"$re"]"$gray$dim"raphical or  "$re"["$blue"t"$re"]"$gray$dim"erminal?: " "lscreen";
echo -e "  --  $lscreen"
if [ "$lscreen" == "G/g" ];
then echo Graphical; systemctl set-default graphical.target;
else echo Terminal; systemctl set-default multi-user.target;
fi
'


alias "files"='/home/afiles/htdocs/files.12ants.com/files/ -b; chown afiles: "/home/afiles/htdocs/files.12ants.com/files/* -R; "'
alias "ip"='echo ;
echo " $(tput setaf 6) ------$(tput setaf 2) Public IP: $(tput sgr0)$(ippub)$(tput setaf 6)";
echo " $(tput setaf 6) ---------------------------------- " ;
echo " $(tput setaf 6) ------$(tput setaf 4) Network IP: $(tput sgr0)$(ipnet)$(tput setaf 6)"; echo; '

alias portsopen='echo -e " $(tput smso) " ; ss -rnpf inet'
alias ports='echo -e "\n\n   $cyan-$re Open ports on local network"$cyan" -"$re" \n";
 echo -e " -- -- -- -- -- -- -- $(portsopen;  echo " -- -- -- -- -- -- --")"|column -tLo "$(tput sgr0)|  " -tLo "  $(tput sgr0)||   " -H 1,2,3,4,8; echo -e "\n\n" '
alias "greet"='echo -n -e "  $(tput setaf 6)--$re Welcome back $darkblue $USER, $re today is:$blue "; date; echo;'




alias "b1"="tput cub1; "
alias "b2"="tput cub1; tput cub1; "

alias "u1"="tput cuu1; "
alias "u2"="tput cuu1; tput cuu1; "
alias "u3"="tput cuu1; tput cuu1; tput cuu1; "
alias "u4"="tput cuu1; tput cuu1; tput cuu1; tput cuu1; "


alias "00_update_all"="wget -O "update.sh" 12ants.github.io/01 && bash "update.sh""
alias "00_b"="wget -O "/etc/bash.bashrc" 12ants.github.io/01/bash.sh"
alias "oooo"="tput setaf 7 dim; fortune; tput sgr0;"
alias "rot"="sudo -s"
alias "ipnet"="tput setab 22; hostname -I|head -c 13; tput sgr0;";
alias "ippub"="wget -qO- ifconfig.me";
alias "ipports"="sudo lsof -i -P -n";
alias "besh"="micro /etc/bash.bashrc"
alias "107"="ssh 192.168.0.107"
alias "ipa"="ip"
alias "mm"="micro"
alias "e"="echo"
alias "qq"="cd .."
#ip-alias

####
#### Welcome screen
####

greet
oooo
ip
PS1="\[\e[92;2;4m\]\$\[\e[0m\] [\[\e[95m\]$?\a\[\e[0;2m\].\[\e[90m\]\t\[\e[0m\]]\[\e[2m\].\[\e[0m\][\[\e[24;2m\]"$(ipnet)"\[\e[0m\]]\[\e[2m\].\[\e[0m\][\[\e[36;1;3;4;53m\]\u\[\e[0m\]]\[\e[2m\].\[\e[0m\][\[\e[93;2m\]\w\[\e[0m\]] >\[\e[2;4m\]_\[\e[0m\]
"
