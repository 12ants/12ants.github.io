
gist() { printf %b "\n\n\n\n\e[4A
 $c2 ${dim}[${re}c${dim}]${re}reate \
 ${dim}[${re}v${dim}]${re}iew \
 ${dim}[${re}u${dim}]${re}pload \
 ${dim}[${re}q${dim}]${re}uit \e[96m";
read -esn1 "g";
if [ -z "$g" ] 2>/dev/null; then printf %b "\nok\n\n"; return 0;
elif [ $g = "c" ]; then $EDITOR|gh gist create;
elif [ $g = "v" ]; then gh gist view;
elif [ $g = "u" ]; then ls|fzf|gh gist create;
elif [ $g = "q" ]; then printf %b "\nok\n\n"; return 0;
fi; echo; }; 
alias 12gist='gist'
