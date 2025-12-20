unset -v load ll; 
printf %b "\e[37;2m•\e[10b\e[2G"; 
load=$(uptime | cut -f 11 -d " " | tr -d ",. "); 
ll=($(seq "$((load / 800))")); 
##
for i in ${ll[*]}; do case $i in 0|1) o=2;; 2|3) o=4;; 4|5) o=3;; 6|7) o=5;; 8|9) o=1;; esac; printf %b "\e[0m\e[38;5;${o}m•"; done; 
l1="$((load / 8))"; printf %b "\e[12G ${l1:0:2}.${l1:(-1)}\n\e[0m";
# printf %b "${l1:1}"; 
##
# ll=($(for i in ${load[*]}; do printf %b "$((${i/./} / 8))"; done)); 
# printf -v "up" %b "${ll[0]:0:(-1)}.${ll[0]:2}"; 
# printf %b "\e[0m\e[2;38m ::::::::\e[0m\e[8D"; 
# for i in $(seq ${ll:0:1}); do ii=${i}; 
# printf %b "\e[3${o}m:"; done; 
# printf %b "\e[12G$up\e[0m
# ";
