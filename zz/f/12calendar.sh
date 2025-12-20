#!/bin/bash
## calll
12calendar() { 
####

# calurl='https://script.googleusercontent.com/macros/echo?user_content_key=AehSKLg_YBNhX7Oit_Rki29oJKGCkyzDaARNMLIq-w3cUYjT0hiWE5UyhIDG6Io3cm0eFcISNs-xi7Q_2k8Mc3LW3h8lEn1E_i9kDyiJ-YXXPvwzoWIV7IOF7VXs3WJbGPPpYVIxd7vOrjXQ9g9PY0eF5Iw2Xf7YRDAVoypcGha5MQs6p7rc_Y0R6CEDqSQKsM5MU4izAwNmn6M1JoAwYBIAKKtIVOtIOfTAvFRHRcdMSNHnOo0ZwEWInLVrYZIXNg&lib=M72QkDm7CT60m1UNRIr2naUe2CZqY5xWx'; 
#### 
dott() { printf %b "\e[0m"; for i in $(seq ${1-45}); do printf %b "·"; done; printf %b "\e[0m"; }; 
####
calcomp() { 
printf -v "epoch" %b "$((EPOCHSECONDS / 60))"; printf -v "epcal" %b "$(($(tail -c10 $HOME/logs/calendar.json) / 60))"; printf -v "epmin" %b "$((epoch - epcal))"; 
}; 
##
for i in {1..18}; do printf %b "·"; done; 
printf %b " $(date +%a\ %b\ %d\ %Y\ \|\ %T)\n"|bat -ppfljava --theme DarkNeon; 
##
##
12calendarget() { 

dott; printf %b "  getting cal ·· "; 
(curl -sL "https://script.google.com/macros/s/AKfycbye8O0u3we9g5Xt3HilbKzLdjlC94OwSj7QPprmzc0pWI5dZ_ORE5YSaFmlyCJ-JqBQ/exec" && printf %b "\nEPOCH_${EPOCHSECONDS}") > $HOME/logs/calendar.json && printf %b "\e[G\e[K"; 
####
( cat $HOME/logs/calendar.json | tr -s "," "\n" | grep -vE 'EPOCH_|h_|description|end_date' | sed '/start_date_time/{s/.[0-9]*[-T]//g}' | cut -f1 -d "+" | sed -e "s/{\"summary/€\n/g"| cut -f 2- -d":" | tr -s "\n€[]" " \n"|sed -e 's/\ \"//g' -e 's/\"\ /\"/g' | col -xb | column --separator "\"" --table --output-separator " | " --table-columns "1234567890123456" --table-right 1 | tail -n+2 | bat -ppflr --theme Visual\ Studio\ Dark+ ) > $HOME/logs/cal.log; 
####
# (cat $HOME/logs/calendar.json | tr -s "," "\n" | grep -vE 'EPOCH_|h_|description|end_date' | sed '/start_date_time/{s/.[0-9]*[-T]//g}' | cut -f1 -d "+" | cut -f 2- -d":" | sed 's/"/\n/' | tr -s "\n\"}" "%%\n" | cut -f2-4 -d"%"|col -xb|column --separator "%" --table --output-separator " | " --table-columns "1234567890123456" --table-right 1|tail -n+2 |bat -ppflr --theme Visual\ Studio\ Dark+ ) > $HOME/logs/cal.log; 
}; 
## \get
####
####
[ -e $HOME/logs/calendar.json ] || 12calendarget; 
cat  $HOME/logs/calendar.json|grep -e "EPOCH" --quiet||12calendarget; 
###
####
calcomp; 
[[ "$epmin" -gt "55" ]] && 12calendarget; 
calcomp; 
# [ $((_epoch_h - _epoch_h_cal)) -gt 222 ] 
# _epoch_h="$((EPOCHSECONDS / 3600))"; _epoch_h_cal="$(($(tail -c10 $HOME/logs/calendar.json) / 3600))"; 
####
####
cat $HOME/logs/cal.log; 
####
dott; 
####
printf %b " ${epmin} mins ago\n"|bat -ppfld --theme Coldark-Cold
# printf %b " ${epmin} mins ago\n"|bat -ppflc --theme DarkNeon; 
# head -n-1 $HOME/logs/calendar.json|sed -e "s/\ \ //g"|grep -vE 'description|end_date|call'|cut -f1 -d+|tr -d '"{}[],\t'|sed -e "s/summary\:\ /\n\ %/g"|tr -d "\n"|tr -s "%" "\n"|sed -e "s/start_date_time............./\ \%\ /g" -e "s/start_date\:/\ \%/g" -e s/start_date_time\:/\%\ /g|tr -s " " " "|column --separator "%" --table --output-width "$COLUMNS" --output-separator '|' --table|bat -ppflr --theme Visual\ Studio\ Dark+; 
}; 

# calle() { cat $HOME/logs/calendar.json |tr -s "," "\n"|grep -vE 'description|end_date'|sed '/start_date_time/{s/.[0-9]*[-T]//g}'|cut -f1 -d "+"|cut -f 2- -d":"|sed 's/"/\n/'|tr -s  "\n\"}" "%%\n"|cut -f2-4 -d"%"|column --separator "%" --table --table-name 1 --output-separator " | " --table-right 1 --table-noextreme 2,3 --table-columns "______ _event,day,time"|grep -vE "_event|EPOCH_"; }; 

# callee() { ((printf %b "\e[0m----------------- "; printf %b "$(date +%a\ %b\ %d\ %Y\ \|\ %T) -----------------\n") |bat -ppfljava --theme DarkNeon ; cat $HOME/logs/calendar.json | tr -s "," "\n" | grep -vE 'EPOCH_|h_|description|end_date' | sed '/start_date_time/{s/.[0-9]*[-T]//g}' | cut -f1 -d "+" | cut -f 2- -d":" | sed 's/"/\n/' | tr -s "\n\"}" "%%\n" | cut -f2-4 -d"%"|col -xb|column --separator "%" --table --output-separator " | " --table-columns "123456789012345" --table-right 1|tail -n+2 |bat -ppflr --theme Visual\ Studio\ Dark+ ) >  $HOME/logs/cal.log; }; 
####
## && printf %b "\nEPOCH_$EPOCHSECONDS " >> $HOME/logs/calc.sh; 
####
# gum style --border normal --padding "0 1"|
## sed -e "s/{/{\n/g" -e "s/}/\n}\n/g" -e "s/,/,\n/g" -e "s/\[/\[\n/g"
####
##cat $HOME/logs/calendar.json|col -xb|jq --indent 0|grep -vE 'description|end_date|call'|cut -f1 -d+|tr -d '"{}[],\t'|sed -e "s/summary:\ /\n%/g"|tr -d "\n"|tr "%" "\n"|sed -e "s/start_date_time............./\%\ /g" -e "s/start_date\:/\ \%/g" -e s/start_date_time\:/\ \%/g|column --separator "%" --output-width "$COLUMNS" --output-separator '|' --table|bat -ppflr --theme Visual\ Studio\ Dark+ ; }; 
########
########
# calurl='https://script.google.com/macros/s/AKfycbyrq3IhGeXMbWMRfdgpoQpMPX3i0y3Fu17_3O5W1Uys/dev'; 

# https://script.google.com/macros/s/AKfycbwSft4XmNq-lCW38uuBjihWM8pKMGrm-1uDmwusW7uksz0uN3WIEobzOt-0NQUgDOASqQ/exec
## 
