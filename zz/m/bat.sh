#!/bin/bash
sleep 2; termux-battery-status > $HOME/logs/battery.log; 
sleep 2; bat="$(cat ~/logs/battery.log |grep -e "percentage"|tr -d 'A-z ,\":';)"; b="$(seq -w 000 $((bat - 1))|tail -n1|cut -c2)"; bc="\e[1;92m"; cat $HOME/logs/battery.log|grep -e "DISCHARGING" &>/dev/null && bc="\e[0;97m"; printf %b '${bc}[\e[0m\e[9${b}m${bat}${bc}]\e[0m ' > $HOME/logs/bat.log; 
printf %b "$bat" > $HOME/logs/bp.log; 
