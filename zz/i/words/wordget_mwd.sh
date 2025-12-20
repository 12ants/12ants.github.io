#!/bin/bash
## word of the day merriam webster 
wordget_mw_com() { 
########
[ "$1" ] && wordget="dictionary/$@" || wordget="word-of-the-day"; 
sh $HOME/88/i/words/wpre.sh; local IFS=$'\n'; fold="$HOME/logs/words/wordlog"; date=$(date +%F-%H_%M_%S); wlog="$HOME/logs/words/tmp/mw_com_$date"; 
########
lynx -width 800 -nonumbers -nomargins -dump \
"https://www.merriam-webster.com/$wordget" | \
sed 's/_*//g' | \
grep -e 'Est. 1828' -m1 -A22 | \
sed -e "/\\/\\//,/*/d" -e 1,5d | \
grep -vE 'What It Means|Prev Next' | \
sed -e 4d -e '5y/\ /\n/' | \
tr -s "\n " "\n " | \
sed -e 's/^[ \t]*//' -e '/^$/d' | \
sed -e '3s/^/[/' -e '3s/$/]/' > $wlog.log;
########
word="$(head -n1 $wlog.log|tee $fold/$word.log)"; 
printf %b "\n----\n$word\n"; 
sed -n 3p $wlog.log | tee -a $fold/word.log; 
sed -n 2p $wlog.log | tee -a $fold/word.log; 
sed -n 4,5p $wlog.log | tee -a $fold/word.log; 
printf %b "----\n"; 
########
########
}; 
########
wordget_mw_com; 
