#!/bin/bash
## /ants/functions.sh - functions for bash shell
###################
## multiselection menu for bash
menu() { 
olpwd="$PWD"; size=($(stty size)); for i in $(seq $size); do echo; done; 
echo -ne '\e[s\e[H\e[J'; green='\e[92m'; cyan='\e[36m'; re='\e[0m'; 
dim='\e[2m'; bold='\e[1m'; c2='\e[36m--\e[0m';
command=bash; [ "$2" ]&& command="$2"; hello=hello; [ $3 ]&& hello=$3; 
dots="$(for i in $(seq $(($(stty size|tail -c4) - 11))); do echo -ne .; done;)"; 
echo -e "$re -------------------  ${green}$hello${re}  --------------------------
 ------------------------------------------------------
 -- [${dim} ^ v ${re}]$dim$cyan Choose${re} ---- \
[${dim}a${re}]$dim$cyan Select all${re} ---- [${dim}h${re}]$dim$cyan Help${re} --
 -- [${dim}Enter${re}]$dim$cyan Select${re} ---- \
[${dim}c${re}]$dim$cyan Confirm${re} ------- [${dim}q${re}]$dim$cyan Exit${re} -- ";
unset OPTIONS_VALUES OPTIONS_STRING SELECTED CHECKED OPTIONS_LABELS ov1 cd; 
if [[ $1 ]]; then cd $1; OPTIONS_VALUES=($(ls -p|grep -v "/")); else OPTIONS_VALUES=($(ls -p $PWD/$1 | grep -v "/")); fi; 
if [[ $4 ]]; then for i in ${OPTIONS_VALUES[@]}; do
OPTIONS_LABELS+=("\e[2m $($4 "$i";) "); done; 
else for i in ${OPTIONS_VALUES[@]}; 
do ft=$(file $i --mime-type -b|head -c4); if [[ $ft == "text" ]]; then
OPTIONS_LABELS+=("\e[2m $(sed -n 2p $i|col -xb|tr -s ';()\\' ' '|cut -c-${size[1]}) "); else 
OPTIONS_LABELS+=("\e[2m $(file -b $i|cut -c-${size[1]}) "); fi; done; echo -e "\e[0J"; fi; 
for i in "${!OPTIONS_VALUES[@]}"; do 
OPTIONS_STRING+="$dots\e[6G "${OPTIONS_VALUES[$i]%/$PWD/}" \e[22G ${OPTIONS_LABELS[$i]};"; done;
OPTIONS_STRING+="\e[1K\n\e[6G\e[1m${cyan} Confirm"; 
####################
checkbox () {
## little helpers for terminal print control and key input
ESC=$( printf "\x1B")
cursor_blink_on()   { printf "$ESC[?25h"; }
cursor_blink_off()  { printf "$ESC[?25l"; }
cursor_to()         { printf "$ESC[$1;${2:-1}H"; }
print_inactive()    { printf "$2  $1 "; }
print_active()      { printf "$2 $ESC[7m $1 $ESC[27m"; }
get_cursor_row()    { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
key_input()         {
local key; IFS= read -rsn1 key 2>/dev/null >&2; 
if [[ $key = "" ]]; then if [[ ${active} == $((idx - 1)) ]]; 
then echo -e "c"; else echo enter; fi; fi; 
if [[ $key = "q" ]]; then echo -e "q"; fi; if [[ $key = "h" ]]; then echo -e "h"; fi; 
if [[ $key = "c" ]]; then echo -e "c"; fi; if [[ $key = "a" ]]; then echo -e "a"; fi; 
if [[ $key = $'\x20' ]]; then echo space; fi; if [[ $key = $'\x1B' ]]; then read -rsn2 key; 
if [[ $key = [A ]]; then echo up; fi; if [[ $key = [B ]]; then echo down; fi; fi; 
 }; 
#####################
## toggler ##########
toggle_option() { arr_name=$1; eval " arr=(\"\${${arr_name}[@]}\")"; option=$2; 
if [[ ${arr[option]} == true ]]; then arr[option]=
else arr[option]=true; fi; eval $arr_name='("${arr[@]}")'; };  
retval=$1; IFS=';' read -r -a options <<< "$2"; if [[ -z $3 ]]; 
then unset defaults; else IFS=' ' read -r -a defaults <<< "$3"; fi; 
selected=(); for ((i=0; i<${#options[@]}; i++)); do
selected+=("${defaults[i]:-false}"); printf "\n"; done
## determine current screen position for overwriting the options
lastrow=$(get_cursor_row); startrow=$(($lastrow - ${#options[@]})); 
## ensure cursor and input echoing back on upon a ctrl+c during read -s
trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
cursor_blink_off; active=0; while true; do idx=0;
## print options by overwriting the last lines
for option in "${options[@]}"; do prefix="\e[0m [ ]";
if [[ ${selected[idx]} == true ]]; then prefix="\e[0m [$green*$re]"; fi
cursor_to $(($startrow + $idx)); if [ $idx -eq $active ]; 
then print_active "$option" "$prefix"; else print_inactive "$option" "$prefix"; fi; ((idx++)); done;
## user key control
case `key_input` in
enter) toggle_option selected $active;;
space) toggle_option selected $active;;
a) sel_all selected $active;;
c) break;;
h) halp;;
q) cd "$olpwd"; echo -e "\e[?25h"; return 0;;
up) ((active--)); if [ $active -lt 0 ]; then active=$((${#options[@]} - 1)); fi;;
down) ((active++)); if [ $active -ge ${#options[@]} ]; then active=0; fi;;
esac; done; cursor_to $lastrow; echo; cursor_blink_on; eval $retval='("${selected[@]}")'; } 
####################
## select all ######
sel_all() { arr_name=$1; eval " arr=(\"\${${arr_name}[@]}\")"; option=$2; 
if [[ ${arr} == true ]]; then for oi in ${!arr[@]}; do arr[oi]=; done; else 
for oi in ${!arr[@]}; do arr[oi]=true; arr[-1]=""; done; fi; eval $arr_name='("${arr[@]}")'; } 
#####################
## help-section ####
halp() { local LESS=; echo -e '\n\n\e[6m'$cyan'--\e[37m bash-menu '$c2' \n
-- use as such: \n\nmenu "option1 option2 opt..." "command" "desc" \n
if no args are made default options are current folder contents. 
"bash" is default command. \ndefault descriotion if second line from file if readable. 
else file class is displayed.\n\n'$cyan'--'$re'\nhttps://github.com/aeniks\n'$cyan'--'$re'
enjoy!\n'$c2'\n\n\n\n['$cyan'Q'$re']uit\n\n\n\n'|command less -JR --use-color --tilde --quotes=c; }; 
#####################
checkbox SELECTED "$OPTIONS_STRING"; ######## << call functions
for i in "${!SELECTED[@]}"; do if [ "${SELECTED[$i]}" == "true" ]; 
then CHECKED+=("${OPTIONS_VALUES[$i]}"); fi; done; 
## confirm ##########
if [ -z $CHECKED ]; then 
echo -e "\n \e[4;32mYou chose:\e[0m nothing"; cd "$olpwd";
echo -ne "\n $c2 Try again? \e[2m[\e[0my\e[2m/\e[0mN\e[2m]\e[0m "; 
read -n1 -ep "" "yn"; 
if [ "$yn" != "${yn#[Yy]}" ]; 
then menu "$1" "$2" "$3" "$4"; return 0; 
else cd "$olpwd"; echo -e "\e[?25h\n Nope\n"; return 0; fi
else
echo -e "\n \e[4;32mYou chose:\e[0m${CHECKED[@]/#/\\n" "}";
#echo -ne "\n $c2 Current command to execute is: $cyan$command$re "
echo -ne "\n $c2 Do you wish to proceed? \e[2m[\e[0mY\e[2m/\e[0mn\e[2m]\e[0m "; 
read -n1 -ep "" "yn"; if [ "$yn" != "${yn#[Nn]}" ]; then 
cd "$olpwd"; echo -e "\e[?25h\n Nope\n"; 
return 0; else 
echo -e "\n $c2 OK"; 
## after ############
## EXECUTE ##########
printf " $c2 Command to execute:"; read -rep " " -i "$command" "command";
for i in "${CHECKED[@]}"; do echo -e "\e[0m $c2 Installing $i \e[2m"; sleep 0.1; 
#[ "$2" ]|| bash $i; [ "$2" ]&& 
$command $i; 
echo -e "\e[0m $c2 $i$green Installed$re \e[2m"; done; cd $olpwd; echo -e "\n Done"; fi; 
echo -e "\e[0m"; fi; 
}; ## END MENU ##
#################
## 12_ menu #####
#################
