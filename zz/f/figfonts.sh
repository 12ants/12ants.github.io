#!/bin/bash
## list figlet fonts
figfonts() { local FZF_DEFAULT_OPTS=; figall=($(basename -a $PREFIX/share/figlet/*.flf $PREFIX/share/figlet/*.tlf|sed -e 's/\..*//g')); ffzz=($(printf %b "${figall[*]}" | command fzf --tmux 'center,100%,98%' -i --preview "figlet -f {} "${1-aZ8}"|bat -ppfl${2-java} && echo -e "${2-java}"; figlet -f {} {}|bat -ppfld; printf %b "-d"" --cycle --wrap --preview-window 'top,50%,wrap,noborder' --wrap-sign '' --bind 'q:abort' --border 'none' --multi)); printf %b "\n${ffzz[*]} \n--\n$\e[95m\ffzz\e[0m\n"; }; 
##
# figfonts() { local FZF_DEFAULT_OPTS=; IFS=$'\n\t '; ffzz=($(figlist|grep -vE ' |utf8'|command fzf --tmux 'center,100%,98%' -i --preview "figlet -f {} "$@"|bat -ppfljava; figlet -f {} {}|bat -ppfld" --cycle --wrap --preview-window 'top,50%,wrap,noborder' --wrap-sign '' --bind 'q:abort' --border 'none' --multi; )); printf %b "\n${ffzz[*]} \n--\n$\e[95m\ffzz\e[0m\n"|bat -ppflgo --strip-ansi; }; 


