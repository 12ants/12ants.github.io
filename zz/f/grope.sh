#!/bin/bash
## groo
grope() { 
[ -z "$1" ] && printf %b "\n\n\e[A\e[96m --\e[0m msg\e[2m:\e[0m" && read -rp ' ' "mm" || mm="$*"; echo; 

grope:read() { 

export GREP_COLORS="mt=91:ms=95:fn=32:ln=32:bn=32:se=35:sl=38;5;$(shuf -n1 -i 207-215):cx=38;5;$(shuf -n1 -i 121-144):ne"; 
figlet -f 3d "$mm" | grep --color=always -e '.░.' -C5; 
}; 


printf %b "\n\n\n\n\e[4A\e[?25l"; for i in {1..22}; do grope:read "$*"; printf %b "\n\e[9A"; read -sr -n1 -t 0.05 "kk"; [ "$kk" ] && break; done; printf %b "\e[9B\e[?25h\n";
}; 
