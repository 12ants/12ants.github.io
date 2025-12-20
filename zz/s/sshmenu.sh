#!/bin/bash
## ssh local lan menu
sshh() { function sshqmenu () { local IFS=$'\n\t '; unset mark; local ops=($2); [ -z "$2" ] && local ops=(*); local prompt="$1" index="0" cur="0" count="${#ops[@]}"; printf "\n\e[?25l -- $prompt --\n\n"; while true; do local index="0"; for o in "${ops[@]}"; do if [ "$index" == "$cur" ]; then printf %b "\e[0m > \e[7m $o \e[0m\e[K\n"; else printf %b "\e[0m $o \e[K\n"; fi; (( index++ )); done; read -srn1 key; if [[ "$key" == A ]]; then (( cur-- )); (( cur < 0 )) && (( cur = 0 )); else if [ "$key" == B ]; then (( cur++ )); (( cur >= count )) && (( cur = count - 1 )); else if [[ "$key" == C ]]; then [ ${mark[$cur]} = 0 ] && mark[$cur]=1 || mark[$cur]=0; printf %b "\e[K ${mark[@]} ${ops[$mark]} \e[K"; else if [[ $key == "" ]]; then break; else if [[ $key == "q" ]]; then return 1; fi; fi; fi; fi; fi; for i in ${!mark[*]}; do [ "${mark[$i]}" = 1 ] && printf %b "${ops[$i]} ok\n"; done; 
printf %b "\e[${count}A"; done; printf -v sel "${ops[$cur]}"; printf "\e[?25h\n \e[7m $sel \e[0m\n\n"; }; 
sshhmenu() { ipgate="192.168.0"; 
sshqmenu "ssh/mosh - ip address" "$(printf %b ${ipgate}.{14,19,17,20}\\n ${ipgate}.{1..10}\\n)"||(printf %b "\e[?25h\n"; return 1)||return 0; 
selip="${sel}"; 
sshqmenu "port" "$(printf %b 22\\n8022)"||(printf %b "\e[?25h\n"; return 1)||return 0; 
selpo="${sel}"; printf %b "\n\n\e[A -- user "; read -rep ' ' -i "aa" "selus"; 
printf %b "mosh -P $selpo ${selus}@${selip}\n"|tee -a >> $HISTFILE; printf %b "mosh -P $selpo ${selus}@${selip}\n"; history -a; history -n; 
mosh -P $selpo ${selus}@${selip}; 
printf %b "\n-------- mosh exit --------\n"; 
printf %b "mosh -P $selpo  ${selus}@${selip}\n"; echo; }||return 0; sshhmenu; }; 
sshh; 
