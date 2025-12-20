#!/bin/bash
#history but better
#fzf$fzt --height ~88% --tac --inline-info --expect "q" -m -i
unalias hh 2>/dev/null; 
hh() { 
unset -v hh; 
##
[ $TMUX ] && fzt="-tmux -h"; [ -z $tmp ] && \
(tmp="$HOME/tmp"; mkdir -m 775 -p  $tmp 2>/dev/null; ); 
##
h1="$tmp/$(id -nu|tr -d "\n"; date +__%__y%m%d_%H_%M_%S).sh"; touch $h1; 
####
if [ $PREFIX ]; 
####
then \
history -s "$(bat -ppfljava $HISTFILE|tr -s "\n" "\n"|uniq -u|fzf --tac -i -m --wrap --cycle --highlight-line --wrap-sign="" --bind "q:abort" --style="minimal" --info inline --preview-window "hidden"; if [ $? != 0 ]; then $(return 1); echo; else history -a; history -n; fi; )"||return 1 >> $HISTFILE; if [ $? != 0 ]; then echo okok; return 1; else history -a; history -n; fi; 
####
# [ "${hh}" ] && printf %b "\n${hh[*]}\n"|tee -a $HISTFILE; 
####
####
else \
#history -s "$(unset FZF_DEFAULT_OPTS; bat -ppfljava $HISTFILE|tr -s "\n" "\n"|uniq -u|fzf --tac -i -m --cycle --bind "q:abort" --scheme history --no-inline-info --no-border || return 1 >> $HISTFILE || return 1; )"; 
hists="$(unset FZF_DEFAULT_OPTS; bat -ppfljava $HISTFILE|fzf --tac -i -m --cycle --ansi --bind "q:abort" --scheme history --no-inline-info --no-border)"; 
fi; 
####
# [ "${hh}" ] && printf %b "${hh}" | tr -s "\n" " "; tee -a $HISTFILE; fi; 
####
####
history -s "$(printf %b "${hists} \n") "; 
history -a; history -n; 
[ -z "${hists}" ] && return 0; 
if [ "$(tail -n 1 $HISTFILE)" ]; then 
printf %b "\n\e[96m-\e[222b\e[0m\n"; 
tail -n1 $HISTFILE | tee $h1; 
printf %b "\e[96m-\e[222b\e[0m\nsaved to: \n$dim$h1$re
\e[96m-\e[222b\e[0m
1) open/edit\n\
2) cp to: \n\
4) gist \n\
5) custom cmd \n"; 
read -sn1 "ny"; 
case $ny in 
1) $EDITOR $h1;; 
2) read -ep "cp to: " -i "$HOME/" hhto; cp $h1 $hhto;; 
4) read -ep "name: " -i "$h1" h2; mv $h1 $h2; gh gist create $h2;;  
5) read -ep "cmd: " -i "$PREFIX/bin/" "h2"; $h2 $h1;; 
*) return;; 
esac; 
else printf %b " -- ok \n"; 
fi; 
# printf %b " -- ok \n"; fi; fi;else 
# read -sn1 "ny" && if [ -z $ny ]; then echo -e "$h1 $h2"; cat $h1; printf %b "\n\e[A${hh[*]}\n"; elif [ $ny = 1 ]; then 
# elif [ $ny = 2 ]; then elif [ $ny = 4 ]; then elif [ $ny = 5 ]; then 

}; 


