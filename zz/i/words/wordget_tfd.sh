#!/bin/bash
wordget_tfdictionary_com() { 
####
sh $HOME/88/i/words/wpre.sh; 
####
local IFS=$'\n'; 
date="$(date +%F-%H_%M_%S)"; 
fold="$HOME/logs/words/wordlog"; 
wlog="$HOME/logs/words/tmp/thefreedictionary_com_$date"; 
####
lynx -dump 'https://www.thefreedictionary.com/_/WoD/rss.aspx' -width 800 -nonumbers -nomargins -force_empty_hrefless_a | tr '<>/' '\n' | grep -e 'Definition' | cut -f2 -d" " --complement > $wlog.log; 
###
word="$(head -n1 $wlog.log|cut -f1 -d" ")"; 
####
head -n1 $wlog.log|tr -s "\n " "\n " | \
sed -e "s/[(]/\n/" -e "s/[)]\ /\n\n/" | sed -e 's/ $//' > $fold/$word.log; 
####
printf %b "\n----\n$word\n----\n"; 
####
}; 
wordget_tfdictionary_com; 
