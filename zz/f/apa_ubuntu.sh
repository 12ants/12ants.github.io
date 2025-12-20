#!/bin/bash
## installaaaaa

apa_ubuntu () { 
local IFS=$'\n\t '; [ -z $PREFIX ] && [ $UID -gt 0 ] && sudo=sudo; 

printf %b "\n\n\e[A -- ok\n "; 
$sudo printf %b "\n\n\e[A -- ok\n "; 


[ -e $HOME/logs/apt_ubuntu.list ] || $sudo apt list 2>/dev/null | cut -f1 -d"/" | tee $HOME/logs/apt_ubuntu.list; 
####
apub=($(cat $HOME/logs/apt_ubuntu.list | \
fzf-tmux -h 99% -w 99% -m -i --preview "$sudo apt show {} 2>/dev/null|bat -ppfljava" --bind "q:abort"||exit))||return 1 && 
[ $apub ] && printf %b "\n\n\e[A  -- install: ${apub[*]} ? [Y/n] " && \
####
read -sn1 "ny"; 
[ -z $ny ] && tmux split-window -e apubt="${apub[*]}" -e "sudo=$sudo" \
'$sudo nala update; printf %b "\n -- ${apubt[*]} -- \n"; $sudo nala install -y ${apubt[*]}; read -t 2 -n1 -p " [o]k " aa; '; 
####
####
printf %b "\n  ok  \n "; 
####
####
}; 
# $sudo nala upgrade -y && 
