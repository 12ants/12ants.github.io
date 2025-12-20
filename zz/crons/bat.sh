#!/bin/bash
termux-battery-status > "$HOME/logs/b/battery.log"; 
cat ~/logs/b/battery.log|grep -e "percentage"|tr -d 'A-z ,\":' > "$HOME/logs/b/bp.log"; 
####
# bat="$(
####
# bcolor="$(($(cat ~/logs/b/bp.log)/10*4+124-4)) | tee ~/logs/b/bcolor.log)"; 
###
# bcharge='\e[1;92m'; cat $HOME/logs/b/battery.log|grep -qe "DISCHARGING" 2>/dev/null && bcharge='\e[0;97m'; 
####
# printf %b '${bcharge}[\e[0m\e[${bcolor}m${bat}${bcharge}]\e[0m ' > $HOME/logs/b/bat.log; 
