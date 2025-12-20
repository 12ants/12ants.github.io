#!/bin/bash
12localan() { 
## discover lan w ping & ssh 
#ipt=$(mktemp; ); 
mkdir -p $HOME/logs/iplocal/ 2>/dev/null; 
rm $HOME/logs/iplocal/* 2>/dev/null;  
c5='    \e[96m--\e[0m'; 
c6='\e[96m--\e[0m'; 
wlan="$(cat $HOME/logs/wlan.sh)"; 
iploc="$(cat $HOME/logs/wlan.sh)"; 
# printf %b "\n\n\n\n\e[4A\n\e[96m --\n\e[0m "; 
# read -ep '> ' -i "${wlan[*]}" "iploc"; 
printf %b "\e[?25l\n$c5 checking ips\e[2m ...\e[0m \t\t [q]uit $c6\n\n\n\n\e[4A\n\n"; 
# ip -4 n
for ip in {0..66}; do printf %b "\e[K"; 
if (ping -c 2 ${iploc%.*}.${ip} &>/dev/null); 
then \
ipp="${iploc%.*}.${ip}"; 
printf %b "\e[K\n\n$ipp\e[K\e[A\[K"; 
touch $HOME/logs/iplocal/$ipp; 
(nmap ${ipp} --system-dns --open -p 22,8022 2>/dev/null|grep -e "open"|cut -f1 -d"/"|tr -s "\n" " ") > $HOME/logs/iplocal/${ipp} 
fi & disown; 
# printf %b "\e[K\n${iploc%.*}.$i" && 
printf %b "\e[K\e[A\e[K"; 
read -t 0.05 -n1 -s -p "${iploc%.*}.$ip " "ny"; [ $ny ] && printf %b "\n\n\e[?25h" && return 0 && break; done; 
# printf %b "${iploc%.*}.$i\n" >> "$ipt"& disown; \
printf %b "\e[?25h";  
printf %b "\e[K\n----------------\n\n"; 
# ipends=($(cat $ipt|cut -f4 -d"."; ));
rm $HOME/logs/iplocal/$iploc 2>/dev/null; 
iplocal=($(command ls $HOME/logs/iplocal; )); 
# iplocall=-($iploc);
# command ls "$HOME/logs/iplocal"; echo; 

# for ip in ${iplocal[*]}; do (nmap --open $ipp -p 22,8022 --system-dns 2>/dev/null|grep -e "open"|cut -f1 -d"/"|tr -s "\n" " ") > $HOME/logs/iplocal/$ipp; done; 

printf %b "\e[?25h"; 
## selection menu 
lomenu() { 
local IFS=$'\n\t '; 

iplogs=$HOME/logs/iplocal;
ops=($2); [ "$2" ] || \
ops=($(for i in  $(command ls -1 $iplogs); do [ "$(command ls ${iplogs}/${i} -s|cut -c1-2)" -gt 0 ] && printf %b "$i:$(cat $iplogs/$i)\n"; done));
local prompt="$1" index="0" cur="0" count="${#ops[@]}";  
# ops=($(command ls -1 $HOME/logs/iplocal)); 
# local desc=()
for i in "${!ops[*]}"; do echo; done; printf %b "\e[${#ops[*]}A"; 
printf "\e[?25l$c5 $prompt $c6\n"; ## print prompt
while true; 
do local index="0"; 
for o in ${ops[*]}; ## print option
do if [ "$index" = "$cur" ]; 
then printf %b " > \e[7m ${o} \e[0m\n"; ## mark & highlight the current option
else printf %b "    ${o} \e[0m\n"; fi; 
(( index++ )); 
done; ## list all options (option list is zero-based)
####
####
read -s -r -n1 key; read -s -n1 -t.0005 bb; read -sr -t.0005 cc; 
[ $cc ] && case $cc in A)key=up;;B)key=down;;C)key=right;;D)key=left;; esac; 
####
case $key in 
up) (( cur-- )); (( cur < 0 ))&& (( cur = 0 ));; 
down) (( cur++ )); (( cur >= count ))&& (( cur = count - 1 ));; 
q) printf %b "\n\n\e[?25h"; return 0; break;; 
*) break;;
esac; 

printf %b "\e[2K\e[${count}A"; 
done; 
# go up to the beginning to re-render



printf -v sel "${ops[$cur]}"; 
printf %b "\e[?25h\n\e[A$c5 user: "; 
read -re -i "aa" "u"; [ -z $u ]&& u=$UID; 
printf %b "\e[?25h$c5 connecting to: \e[7m ${u}@${sel} \e[0m\n\n"; 
# -p $(cat $logs/$o) 
echo; 
sshlatest="${sel/:*/} -l $u -p ${sel/*:/}"; 
printf %b "${sshlatest}"|tr -s "\n" " " > $logs/$sel; 
sleep .5; 
# printf %b "ssh ${sshlatest[*]}" >> ~/.bash_history; 
printf %b "\nssh ${sshlatest[@]}";
ssh ${sshlatest}; 
}; 
lomenu " open lan ip:s "; 
history -a; history -n; 
history -s "ssh ${sshlatest}"; 
}; 
