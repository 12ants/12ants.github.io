#!/bin/bash 
################
mkdir $HOME/logs/b -p -m 775 2>/dev/null; 
[ "$PREFIX" ] && . "${HOME}"/88/crons/bat.sh & disown; 
# [ "$PREFIX" ] &&
touch $HOME/logs/b/battery.log; 
touch $HOME/logs/b/bp.log; 
chmod 775 $HOME/logs/b/bp.log; 
yellow='\e[93m'; cyan='\e[96m'; re='\e[0m'; bc=0; dim='\e[2m'; 
##
wlan="$(cat "$HOME/logs/iploc.log" 2>/dev/null)"; 
################
_bat() { 
if [ "$PREFIX" ]; then 
printf -v "batstat" %b "$HOME/logs/b/battery.log"; 
printf -v "batcap" %b "$HOME/logs/b/bp.log"; 
else 
####
if [ -e "/sys/class/power_supply/battery/status" ]; then 
printf -v "batstat" "/sys/class/power_supply/battery/status"; 
printf -v "batcap" "/sys/class/power_supply/battery/capacity"; 
elif [ -e "/sys/class/power_supply/BAT0/status" ]; then 
printf -v "batstat" "/sys/class/power_supply/BAT0/status"; 
printf -v "batcap" "/sys/class/power_supply/BAT0/capacity"; 
elif [ -e "/sys/class/power_supply/BAT1/status" ]; then 
printf -v "batstat" "/sys/class/power_supply/BAT1/status"; 
printf -v "batcap" "/sys/class/power_supply/BAT1/capacity"; 
else unset -v batcap batstat; 
fi; fi; 
####
[ -e "$batcap" ] && batp="$(cat $batcap)"; 
grep -wqi "Charging" "$batstat" && bcharge="\e[0m\e[38;5;42;1m" || bcharge="\e[0m\e[2m"; 
bcolor="$(printf %b "$((batp / 10 * 4 + 124 - 4))"|tee ~/logs/b/bcolor.log)"; 
[ -e "$batcap" ] && printf %b " ${bcharge}[${re}\e[38;5;${bcolor}m${batp}${bcharge}]$re"; 
####
}; 
################
# [[ "$HOSTNAME" == "localhost" ]] && unset HOSTNAME || \
printf -v "_host" %b "[\e[95m${HOSTNAME-$HOSTTYPE}\e[0m] "; 
################
_dtime() { hh=1$(date +%H;); mm=1$(date +%M;); ss=1$(date +%S); 
printf %b "\e[38;5;$((hh + 22))m${hh:1:2}$re:\e[38;5;$((mm + 22))m${mm:1:2}$re:\e[38;5;${ss/0/1}m${ss:1:2}\e[0m" 2>/dev/null; }; 
# _etime() { printf %b "\e[38;5;${EPOCHSECONDS:8:2}m${EPOCHSECONDS:6:4}\e[0m";  }; 
################
alias gits='[ -e $PWD/.git ] && ggii="$(git status --short 2>/dev/null|grep "" --quiet && printf %b "41"|| printf %b "44"; )" && printf %b "\e[0m\e[${ggii}m git \e[0m"'; 
ee() { [ $? = 130 ] && echo gg; }; 
#alias gitstat='git status --short 2>/dev/null|tr "\n\t " " | "|bat -ppfld --theme Coldark-Dark'; 
# (printf %b "${gitst}\t
################
# . "$HOME/88/i/colors.sh"; 
################
# \e[0;2m'${wlan%.*}'.\e[0;1m'${w[${wlan/*./}]}'${wlan/*./}
# st() { st=$?; [ $st = 130 ] && printf %b "\e[2A\r"; return $st; }; 
################
# trap 'printf %b "\e[K\e[2A\e[K"' 2; 
##
# ['$re'$(_etime)'$re']\
PS1='\e[0m[\e[0;1;38;5;$((2 + $?))m$?'$re']\
$(gits||printf " ")\
['$re'$(_dtime 2>/dev/null)'$re']\
'$re'$(_bat) \
['$re'${wlan%.*}.\e[38;5;${c[idn]:0:4}${wlan/*./}'$re'] \
['$re'\e[0m'${w[${wlan/*./}]}'\e[3${c[idn]:13:1}m\e[48;5;${c[idn]:0:4}${model:0:12}'$re'] \
['$re$cyan'\u'$re']'$re' '${_host}'['$re$yellow'\w'${re}]' \e[?25h\e[0m \n'; 
