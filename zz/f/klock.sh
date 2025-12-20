#!/bin/bash
## klock
klock() {
printf "\e7\e[?25l\e[?47h"; clear;
########### variables
#figlist=($(figlist|batcat -pp --line-range 4:|head -n-5)); 
###################

# figlist=($(cat $HOME/logs/fig.log)); 
# figlist=(3d 4x4_offr fender contrast Electronic 4maxebbs_1__ aquaplan doh Big_Money-sw Electronic s-relief devilish Big_Money-nw poison )
local IFS=$'\n'; 
figlist=($(cat $HOME/start/info/fig_font_list.log)); 
batlog="${HOME}/logs/bat.log"; 
########
batlist=($(cat $HOME/start/info/bat_lang_list.log)); 
batlang="$(shuf -n1 -e ${batlist[@]})"; 
########
figlog="${HOME}/logs/fig.log"; 
figfont="$(shuf -n1 -e ${figlist[@]})"; 
figlength="$(figlet -f "$figfont" $(date +%T))";
###########
########### functions
fsize() { 
sizeh=$(stty size|cut -f1 -d" "); sizew=$(stty size|cut -f2 -d" "); 
sizehh="$((${sizeh}/2-9))"
} 
fsize; 
ftime() { 
printf "\e[$((${sizeh}/2-8));$((${sizew}/2-2))H\e[1m$(date +%H:%M)"; ## print time plainly ## move to center
printf "\e[$((${sizeh}/2-4))H\e[0J";  
} 
fday() { 
dag="$(date +%#A" den"%e":de "%#B)"; daghw=$((${#dag}/2)); halfw=$((${sizew}/2)); printf "\e[2m\e[2J\e[${sizehh};$((${halfw}-${daghw}))H${dag}\e[0m"; ## print day
} 

unset -v f; declare -i f; f="$(shuf -en1 ${!figlist[@]})"; 
unset -v l; declare -i l; l="$(shuf -en1 ${!langlist[@]})"; 

# while true; do figfont="$(shuf -n1 -e ${figlist[@]})"; 
# figlength="$(figlet -f "$figfont" $(date +%T))"; 
# [ "${#figlength}" -gt 8 ] && break; done; 

fday; 
####
while true; do date="$(date +%H:%M;)"; ftime; batlang='d'; 
[ "$1" ] && figfont="$1" && key="s"; [ "$2" ] && batlang="$2";
if [ "$batlang" != 22 ]; then 
figlet -w "$sizew" -cf "$figfont" "$date"|batcat -ppl "$batlang"; ## time
else printf "\e[36m"; figlet -w "$sizew" -cf "$figfont" "$date"; fi; ## time
read -t60 -srn1 "key"||key=0; printf "$((kk++))\e[2K"; [ "$kk" -eq 44 ] && key="c" && kk="0";

while read -rsn1 k; do
[ "$k" = A ]&&key=up&&printf "    ^   up"&& break;
[ "$k" = B ]&&key=down&&printf "    v   down"&& break;
[ "$k" = C ]&&key=right&&printf "    >   right"&& break;
[ "$k" = D ]&&key=left&&printf "    <   left"&& break;
[ "$k" = q ]&&key=q&&printf "    ĸ   qko"&& break;
done;

case $key in 
up) figfont="${figlist[$((f--))]}";; 
down) figfont="${figlist[$((f++))]}";; 
left) lang="${batlang[$((l++))]}";; 
right) lang="${batlang[$((l++))]}";; 
s) printf "$figfont\n" >> "$figlog";; 
b|l) printf "$batlang\n" >> "$batlog";; 

esac; 
fsize; fday; 
printf "\e[H\e[0J\e[2m$batlang \e[22G (${l}/${#batlist[*]}) \e[42G (${f}/${#figlist[*]}) $figfont          "; 
printf "\e[2m\e[${sizehh};$((${halfw}-${daghw}))H${dag}\e[0m\e[0J"; 


if [ "$key" = "c" ]; then 

figfont="${figlist[$((f++))]}"; fsize; fday; 
printf "\e[H\e[0J\e[2m$lang (${f}/${#figlist[*]}) $figfont          "; 
printf "\e[2m\e[${sizehh};$((${halfw}-${daghw}))H${dag}\e[0m\e[0J"; 


elif [ "$key" = "" ]; then break; 
elif [ "$key" = "q" ]; then break; 
elif [ "$key" = " " ]; then break; 
elif [ "$key" = "s" ]; then kk="45"; 
printf "\e[2m\e[0;${sizew}Hs"; 
printf "$figfont\n" >> "$figlog";
elif [ "$key" = "l" ]; then fsize; fday; lang=$(shuf -n1 -e ${figlist[@]}); 
printf "\e[2m\e[H$lang $figfont       ";fi; done; 
printf "\e[?47l\e[?25h\e[0m\e8";
}

#klock




