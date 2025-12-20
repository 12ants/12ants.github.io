#!/bin/bash
## selection menu 
qmenu() { 
local IFS=$'\n\t '; unset mark; 
local ops=($2); [ -z "$2" ]&& local ops=(*); 
local prompt="$1" index="0" cur="0" count="${#ops[@]}"; 
printf "\n\e[?25l    -- $prompt --\n\n"; ## print prompt
##################################################
##################################################
while true; do local index="0"; for o in "${ops[@]}"; ## print options
do if [ "$index" == "$cur" ]; 
then printf %b "\e[0m > \e[7m $o \e[0m\e[K\n"; ## mark & highlight the current option
else printf %b "\e[0m    $o  \e[K\n"; 
fi; 
(( index++ )); 
done; ## list all options (option list is zero-based)
read -srn1 key; ## wait for user to key in arrows or ENTER
if [[ "$key" == A ]]; then (( cur-- )); (( cur < 0 ))&& (( cur = 0 )); 
elif [ "$key" == B ]; then (( cur++ )); (( cur >= count )) && (( cur = count - 1 )); 
elif [[ "$key" == C ]]; then [ ${mark[$cur]} = 0 ] && mark[$cur]=1 || mark[$cur]=0; 
printf %b "\e[K ${mark[@]} ${ops[$mark]} \e[K";
elif [[ $key == "" ]]; then break; 
elif [[ $key == "q" ]]; then break; fi; # enter
for i in ${!mark[*]}; do [ "${mark[$i]}" = 1 ] && printf %b "${ops[$i]} ok\n"; done; 
printf %b "\e[${count}A"; done; # go up to the beginning to re-render

####
printf -v sel "${ops[$cur]}"; printf  "\e[?25h\n \e[7m $sel \e[0m\n\n"; }; 


for i in ${!mark[*]}; do [ "${mark[$i]}" = 0 ] && printf %b "${ops[$i]} ok\n"; done
