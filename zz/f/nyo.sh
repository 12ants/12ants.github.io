
nyo() { [ -z $1 ] && question="Continue" || question="$1"; printf %b "\n\n\n\n\e[2A \e[0m\e[96m--\e[0m ${question[*]}? "; printf %b "\e[0\[\e[2mY\e[0m/\e[2mn\e[0m]"; read -n1 -rsp ' ' 'yno'; [[ "$yno" == "${yno#[Nn]}" ]] && $2 $3 $4 $5 || (printf %b "nope\n\n"; return 1;); }; 
