#!/bin/bash
wordget_dictionary_com() { 
local IFS=$'\n'; fold="$HOME/logs/words/dictionary_com"; mkdir $fold -p -m 775 2>/dev/null; 
####
wowo=($(lynx -width 2400 -dump https://www.dictionary.com/e/word-of-the-day | grep -m 1 -e "Learn More" -B7|sed -e '/^$/d' -e 's/\]\ /\]\n/g' -e 's/^[ \t]*//'|sed -e 4d -e 7d)); 
####
printf %b "${wowo[*]}" > $fold/${wowo/\ /_}.log; 
###s
}; 
####
wordget_dictionary_com; 
