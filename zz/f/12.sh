# unalias 12; 
12() { 
for i in ~/start/funcs/*.sh; do . $i; done; 
printf %b "\n\n\e[A\e[96m --\e[0m list functions? [Y/n] "; 
read -n1 -s 'ny'; [ -z $ny ] && ls=($(ls ${HOME}/start/funcs|fzf --preview "bat -ppfljava ~/start/funcs/{}")); 
printf %b "\n${ls[*]}\n"; ${ls/.*/}; 
}; 
