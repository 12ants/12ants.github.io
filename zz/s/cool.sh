#!/bin/bash
# co=0; wc=0; 
# for i in $(pastel distinct 44 | pastel format hex); 
# do printf %b "co[$((wc++))]=\"$i\"; \n"; done
####

ok=0; o=00; 

coolo() { for i in $(pastel distinct|pastel format hex); 
do printf %b "co[$((ok++))]=\""; printf -v "oo[o++]" %b "$(printf %b "$(pastel format ansi-8bit "$i") "|cut -c 8-10|tr -d "m")"; [ ${#oo[o]} -lt 3 ] && printf %b "0${oo[o]}"||printf %b "0\b${oo[o]}"; printf %b " ${i} "; pastel textcolor "$i"|pastel format brightness|cut -c1|tr -s "\n" " "; pastel format name "$i"|tr -s "\n" " "; printf %b "\"; \n"; done > $HOME/logs/coolors.sh; }; 
coolo; 
chmod 775 "$HOME"/logs/coolors.sh; 






# 
# ok=0; o=0; unset -v co; 
# for i in $(pastel distinct 41|pastel format hex); 
# do printf %b "co[$((ok++))]=\""; 
# printf -v "oo[o++]" %b "$(printf %b "$(pastel format ansi-8bit "$i") "|cut -c 8-10|tr -d "m")"; [ ${#oo[o]} -lt 3 ] && printf %b "0${oo[o]}" || printf %b "0\b${oo[o]}"; 
# printf %b " ${i} "; 
# pastel textcolor "$i"|pastel format brightness|cut -c1|tr -s "\n" " "; 
# pastel format name "$i"|tr -d "\n"; 
# printf %b "\"; \n"; 
# done | tee "$HOME"/logs/coolors.sh; chmod 775 "$HOME"/logs/coolors.sh; 
####
####
# printf %b " $((o++)) "
printf %b "\n\n\e[A -- do cool? [Y/n] "; 
read -srn1 "ny"; [ -z "$ny" ] && 
. "$HOME"/logs/coolors.sh && \
for i in "${co[@]}"; do printf %b "$i kk \n"; done || 
printf %b "\n\n\e[A -- ok \n\n" && return 0;  
# ${co[*]}; 
# printf %b "\";    \t ## "; pastel format ansi-8bit "${i}"; 






# o=0; wc=0; w=0; declare -a co; 
# for i in $(pastel distinct 44 | pastel format hex); 
# do \
# printf -v "co[w++]" %b "$(pastel format ansi-8bit "${i}"|cut -c 11-13 -z)"; 
# printf %b "${i} "|tr -s "\n" " "; 
# printf %b "${i}"|pastel format name|tr -d "\n"; 
# printf %b "${i}"|pastel textcolor|pastel format brightness|cut -c-1|sed -e "s/1/\ 7/g" -e "s/0/\ 0/g"|tr -d "\n"; 
# printf %b "\"; \n"; 
# # |tr -s "\n" " "|sed -e "s/0\./_0/g" -e "s/1\./_7_/g";
# done | tee "$HOME"/logs/coolors.sh; 
# chmod 775 "$HOME"/logs/coolors.sh; 
