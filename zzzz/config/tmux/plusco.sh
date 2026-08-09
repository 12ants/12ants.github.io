#!/usr/bin/env bash
function mnu () { 
local IFS=$'\n'; 
unset -v uhl uhw mm mnu; 
[ "$1" ] && mnu=(${*}) || \
declare -a mnu=($(command ls -1p |head -n $((LINES - 4)))); 
uhl="${#mnu[*]}"; 
uhw=$(printf %b "${mnu[*]}"|wc --max-line-length); 
########
########
########
declare -a mm=($(printf %b "${mnu[*]} "|command fzf-tmux -w "$((uhw + 7))" -h "$((uhl + 3))" -m --cycle --ansi --bind 'enter:print-query' --disabled --info inline:"" --bind 'focus:replace-query,q:abort' --delimiter=' ')); ####
####
printf %b "${mm[*]} \n"; 
####
}; 
mnu
