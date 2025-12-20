#!/bin/bash
wordget_miriam() { 
##
td="$HOME/logs/words/"; mkdir -p -m 775 $td/miriam 2>/dev/null; 
tf="word_merriam_webster_$(date +%y%m%d_%H%M%S).log"; 
##
w3m -dump https://www.merriam-webster.com/word-of-the-day > $td/$tf
#s
local IFS='%'; words=($(cat $td/$tf | grep -e 'Est. 1828' -A20|tail -n+7|grep -vE 'play|Prev Next|━|What It Means|// '|sed 2,4"s/\ /\n/"|tr -s "\n" "\n- "|sed 1,3"a\\\n%\\n"|tr -d "\n")); local IFS=$'\n\t '; 
##
printf %b "${words[*]}" | tee $td/miriam/$words.log; 
}; 
##
wordget_miriam; 
