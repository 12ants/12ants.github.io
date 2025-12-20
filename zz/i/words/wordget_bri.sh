#!/bin/bash
####
sh $HOME/88/i/words/wpre.sh; 
####
wol="$HOME/logs/words/wordlog"
wob="wobrit_$(date +%y%m%d)"; 
####
lynx -nomargins -nonumbers -nolist -width 800 -dump "https://www.britannica.com/dictionary/eb/word-of-the-day" \
| grep -e "\(BUTTON\)" -A20 > $wol/$wob.log; 
####
word="$(sed -n 7p $wol/$wob.log)"; echo; 
##########
##########
sed -n 7p $wol/$wob.log|tr -s " " " " > $wol/$word.log; 
sed -n 9p $wol/$wob.log|tr -s " " " " >> $wol/$word.log; 
(printf %b "["; 
sed -n 8p $wol/$wob.log|tr -d "\n"; 
printf %b "]\n" ) >> $wol/$word.log; 
####
sed -n "/Definition of/,/More Words/p" $wol/$wob.log|sed -n "/\:\ /p"|sed -e "s/\:\ //g" >> $wol/$word.log; 
#########
#########
echo; cat $wol/$word.log; 
mv $wol/$wob.log -t $HOME/logs/words/tmp; 
printf %b "\n----\n$word\n----\n"; 
