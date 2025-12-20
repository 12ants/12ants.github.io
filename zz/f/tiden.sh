tiden() { 
printf %b "\ec"; 
while true; do printf %b "\ec\e[48;5;$((RANDOM%222))m"; 
for i in $(seq $LINES); do printf %b " \e[222b"; done; sleep .5; printf %b "\ec\e[12H"; 


figlet -f Roman -w $COLUMNS -c "$(date +%H:%M)" | bat -ppfljs; 

printf %b "\e[$((LINES - $((RANDOM%12))));$((RANDOM%12))H\e[16A"; 

gum style --border normal --border-foreground "$((RANDOM%222))" --margin "1 4" \
"$(gum style --border normal --padding "1 4" --margin "0 $((RANDOM%4)) 0 $((RANDOM%4))" \
--border-foreground $((RANDOM%222)) \
"$(while true; do [ "$(fortune|tee ~/.ff|wc -c)" -lt 120 ] && break; done; 
bat -ppfljava ~/.ff|fmt -w $((COLUMNS - 25)) -g $((COLUMNS-28))|tr -s "\t " " "; )")"; 
read -st 45 -n1 "kk"; [ "$kk" ] && break; done; 
}; 
