#!/bin/bash
## github searcher
ghs() { 
local IFS=$'\n'; 
local FZF_DEFAULT_OPTS=; 
[ -z $1 ] && read -rep ' -- repo: ' "ghs" || ghs=($@); 
oo=($(gh search repos ${ghs[*]}|sed -e s/\\t/\ /g)); 
[ -z "$tmp" ] && tmp=$HOME/tmp; 
mkdir -pm 775 $tmp/ghs 2>/dev/null; 
rm $tmp/ghs/* 2>/dev/null; 
for i in ${oo[*]}; do 
printf %b "$i" > $tmp/ghs/$(printf %b "${i/\ */}"|sed -e 's/\//@/';); done; 
ghss=($(command ls -tr "${tmp}/ghs" | fzf -i -m --preview "clear; cat $tmp/ghs/{}|sed -e 's/\ /\n--\n/'|bat -ppflzig" \
--preview-window '6,top,wrap' --bind 'q:abort' \
--cycle --info inline --border none; )); 
cd ~/gh; 
for a in ${ghss[*]}; do gh repo clone ${a/@//}; done; printf %b "\e[96m${ghss[*]/@//}\e[0m\n"; ls --color=always --classify -shG ${ghss[*]/*@/}; }; 
####
alias 12githubsearch='ghs'; 
