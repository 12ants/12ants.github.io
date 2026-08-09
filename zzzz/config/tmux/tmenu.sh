#!/bin/bash
function mnu () { 
IFS=$'\n\t '; unset -v uhl uhw mm; 
mnu=(${@}); [ -z "$1" ] && \
mnu=($(command ls -1p|head -n $((LINES - 4)))); 
uhl="${#mnu[*]}"; uhw=$(printf %b "${mnu[*]}"|wc --max-line-length); 
########
########
########
declare -a mm=($(printf %b "${mnu[*]}"|command fzf-tmux -w "$((uhw + 6))" -h "$((uhl + 3))" -m --cycle --ansi --bind 'enter:print-query' --disabled --info inline:"" --bind 'focus:replace-query,q:abort')); ####
####
printf %b "${mm[*]} \n"; 
####
}; 
mnu
