#!/bin/env bash 
mkdir -p $HOME/tmp $HOME/logs/wotd 2>/dev/null; [ -z $PREFIX ]&& sudo=sudo; 
hash w3m 2>/dev/null || $sudo apt install -y w3m &>/dev/null; 
####
time="$(date +%y_%m_%d)"; wotmp="$HOME/tmp/wotd_${time}.log";
####
command w3m -cols 800 -dump https://www.merriam-webster.com/word-of-the-day > $wotmp; 
####
(printf %b 'printf -v "w_w" "'; cat $wotmp|sed -n 39p|\
cut -f1 -d" "|tr -d "\n"; printf %b '";'; echo; ) > $HOME/logs/wotd_m.sh; 
####
(printf %b 'printf -v "w_t" "'; cat $wotmp|sed -n 42p|\
cut -f1 -d" "|tr -d "\n "; printf %b '";'; echo; ) >> $HOME/logs/wotd_m.sh; 
####
(printf %b 'printf -v "w_p" "'; cat $wotmp|sed -n 42p|\
cut -f2- -d" "|tr -d "\n "; printf %b '";'; echo; ) >> $HOME/logs/wotd_m.sh; 
####
(printf %b "printf -v "'w_m'" %b "; printf %q "$(sed -n 48p $wotmp)"; ) >> $HOME/logs/wotd_m.sh; 

# (printf %b 'printf -v "w_m" %q "$(sed -n 48p $wotmp)"'; )

#'' "" \"" ''; cat $wotmp|sed -n 48p echo; ) >> $HOME/logs/wotd_m.sh; 
####
cat $HOME/logs/wotd_m.sh > $HOME/logs/wotd/wotd_m_${time}.sh; 


# printf -v w_c %q "$(sed -n 3p ww22.sh|cut -f1 -d" ")"

