#!/bin/bash
function 12 () { 
local IFS=$'\n\t '; 
local FZF_DEFAULT_OPTS=; 
way="$HOME/zz/i"; 
unalias fzf 2>/dev/null; 

[ $PREFIX ] && fzfz='--wrap-sign=""'; 
ways=($(ls -1p ~/zz/i|grep -v '/')); 
ioio=($(ls -1p $way|grep -v '/'|fzf -m -i --ansi --cycle --bind "0:change-preview-window(right,80%|top,60%|right,99%),q:abort" --info inline --preview-window "border-left,right,92%,wrap" --color 'preview-bg:236' $fzfz --preview "bat -ppf ${way}/{} 2>/dev/null||ls --color always -pm ${way}/{}")); 

[ "$ioio" ] && bat -pfljava ${way}/${ioio}; }; 
# alias 12info='info12'; 
#-tmux -w 100% -h 100%
