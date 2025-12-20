#!/usr/bin/env bash
apa() { 
local IFS=$' \n\t'; 
hash sudo 2>/dev/null && sudo=sudo; [ $PREFIX ] && unset sudo; [ $UID = 0 ] && unset sudo; 
####
FZF_DEFAULT_OPTS='-m -i --ansi --bind "0:change-preview-window(right,50%|top,20%|top,55%|right,20%|hidden),q:abort" --info inline --inline-info --preview-window "wrap,noborder" --preview "bat -ppf {} 2>/dev/null||ls --color always -pm {}"'; 
#apinstalled=($(apt list --installed 2>/dev/null|tail -n +2|cut -f1 -d "/")); 
####
####

aline='\e[96m ----------\e[0m\n'; 


printf %b "\e[?25l\n\n\n\n\n\n\e[5A\e[96m --\e[0;2m [\e[0;92mI\e[0;2m]\e[0mnstall or \e[2m[\e[0;96mr\e[0;2m]\e[0memove ? "; 
read -srn1 "irir"; printf %b "\e[0m\e[?25h \e[42G\e[42m  ok  \e[0m\n"; 
########
case "$irir" in 
i|I|"") instremove="install"; 
apagetlist() { apt list 2>/dev/null|tail -n +2|cut -f1 -d"/" > "$HOME/logs/apts.log" & disown; };; 
####
r|R) instremove="remove"; 
apagetlist() { apt list --installed 2>/dev/null|tail -n +2|cut -f1 -d"/" > "$HOME/logs/apts.log" & disown; };; 
####
*) printf %b "\n be that way then \n\n"; return 0; 
esac; 
####
####
apupdate() { printf %b "\e[96m --\e[0m Updating \e7"; 
apt update &>/dev/null & disown; 
printf %b "\e8\e[K"; ae="$!"; (for i in {1..55}; 
do printf %b "\e[38;5;$((RANDOM%222 + 22))m\u25$((RANDOM%99)) "; 
read -t .2 -srn1 "yu"; [ $yu ] && printf %b "\e[?25l\e[0m gg" && return 1 && break; 
ps|grep -e "$ae" --quiet 2>/dev/null||break; done) 2>/dev/null || return 2; 
printf %b "\e[0m\e[?25h \e[42G\e[42m done \e[0m\n"; };
# apupdate; 
####
####\n\n\n\n\n\n\e[5A
####
printf %b "\e[?25l\e[96m --\e[0m Getting list \e7"; apagetlist; 
printf %b "\e8\e[K"; ae="$!"; 
(for i in {1..55}; 
do printf %b "\e[38;5;$((RANDOM%222 + 22))m\u25$((RANDOM%99))\b"; 
read -t .2 -srn1 "yu"; [ $yu ] && printf %b "\e[?25l\e[0m gg"; 
ps|grep -e "$ae" --quiet 2>/dev/null|| break; done) 2>/dev/null; 
printf %b "\e[0m\e[?25h  \e[42G\e[42m done \e[0m\n"; 
####
# apt show {} 2>/dev/null|tr -s "\n " "\n "|grep -vE "Package|Version|Maintainer|APT-Sources|Download-Size"|sed -e "s/Homepage: //" -e "s/Description: //"|bat -ppfld
####
aapp=($(bat -ppfljava "$HOME/logs/apts.log"|fzf --query " $1" -i -m --color \
preview-bg:0 --bind "q:abort" --preview 'printf %b ""{}\ \ --\ \ ""|bat -ppfljs --theme DarkNeon; ap="$(apt show {} 2>/dev/null|tr -s "\n " "\n "|grep -vE "Bugs|Priority|Package|Version|Maintainer|APT-Sources|Download-Size")"; printf %b "${ap}"|grep -e "Installed-Size: "|cut -f2- -d"-"; printf %b "-----\n"; (printf %b "${ap}"|grep -e "Description: " -A22|sed "s/Description\:\ //"|fmt -g 60; 
printf %b "-----\n"; printf %b "${ap}"|grep -e "Homepage:" -m1 | cut -f2- -d" " && printf %b "-----\n")|bat -ppfld --theme DarkNeon; 
printf %b "${ap}"|grep -vE "Description: |Installed-Size: |Homepage: "|bat -ppfljs --theme TwoDark' --preview-window "wrap,66%,noborder,right" --cycle --ansi --inline-info))||\
(printf %b "\ngg\n\n"&& return 1)|| return 0;
local IFS=$'\n\t '; 
# (cd - &>/dev/null; printf %b "\n\n"&& cd $pwd &>/dev/null&& return 1;)||\
# return 1; cd - &>/dev/null && printf %b "\n\n\n\n\e[4A\n"; 
# bb=" \b"; [[ ${#aapp[*]} == 1 ]] && unset bb; printf %b "$bb ? "; 
printf %b "\e[96m -- \e[0m${instremove}: \n\e[96m ----------\e[0m\n"; 
printf %b "${aapp[*]} ?\n"|bat -ppflc --theme OneHalfDark; 
printf %b "\e[96m ----------\e[0m\n\n\e[2A"
read -rs -n1 "ny"; if [ -z "$ny" ]; then printf %b " \t\t [\e[92mOK\e[0m] \n"; 
# IFS=$'"' \n\t'"'; 

tmux display-popup -E -e "apap=${aapp[*]}" -e "instremove=$instremove" -e "sudo=$sudo" -w "82%" -h "82%" \
'ap=(${apap}); for i in ${!ap[*]}; do printf %b "\n\e[0m${instremove}ing: \e[48;5;$((RANDOM%222 + 22))m ${ap[i]} \e[0m\n-\e[222m\n\e[38;5;$((RANDOM%222 + 22))m"; $sudo apt ${instremove} -y ${ap[i]}; done; printf %b "\n-\e[222b\ndone\n"; read -t2 -n1;'

# for i in {1..55}; do printf %b "\e[48;5;1$(shuf -i 1-9 -z -n1; shuf -i 1-9 -z -n1)m  "; sleep .4; done & disown; printf %b "\e[A\e[K"; 
# for aa in ${ap[*]}; do printf %b "\n $aa \n"; sleep .5; 
# $sudo apt ${instremove} -y ${aa}; 
# printf %b "\n\n----\n\n$aa\n\n"; sleep 1; echo "  "; done; 
# for i in {1..15}; do printf %b "\e[48;5;21${i}m\e[22S\n\n\e[2A ${ap[*]} \e[12G\e[0;95;7m gg "; read -n1 -t .4 xx; done; '; 
# printf %b "\n\n -- ${apap}\n"; read -t1 -n1 sasa; 
# $sudo apt upgrade -y 2>/dev/null|bat -ppfljava --theme DarkNeon; clear; 
elif [ "$ny" = r ]; then 
tmux split-window -l 5 '$sudo apt remove -y ${aapp[*]}|bat -ppfljava --theme DarkNeon; echo ok; read -t2 -n1 xx;'; 

# printf %b "\n\n -- \${aapp[*]}\n\n"|bat -ppflc --theme Nord; 
fi; 
case $ny in ""|r) printf %b " \e[96m--\e[0m ${instremove}ed: \n\e[96m ----------\e[0m\n"; printf %b "${aapp[*]}\n"|bat -ppflc --theme Nord;; esac; 
echo; echo; return 0; 
}; 


# echo; for i in {1..6}; do printf %b "\e[95;4${i}m\e[\u258${i}\e[${COLUMNS}b\n"; sleep .5; done; printf %b "\e[4A\e[?25l\e[4;8;9m\t\t\e[0;96m[ok]"; read -t5 -n1 xx; 

