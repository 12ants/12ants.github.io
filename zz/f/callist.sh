#!/bin/bash
## get notes
callist() { if [[ $wlan != 192.168.0.19 ]]; then ssh -p 8022 192.168.0.19 "termux-notification-list" > $HOME/logs/callist.json; else termux-notification-list > HOME/logs/callist; fi; cat $HOME/logs/callist.json | sed -e "s/\\n/\ /g" | tr -s " " " " | grep -e "content" -C1 | sed -e /\"\"\,/d | grep -e '",' -A1 | cut -f4- -d"\"" | tr -d "\"" > $HOME/logs/callist.log; cat $HOME/logs/callist.log | bat -pfljava --theme Nord|tee $HOME/logs/callist.json; }; 
##########
alias 12get_xiaom_call_list='callist'; 
