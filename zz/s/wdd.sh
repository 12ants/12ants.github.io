
wdd() { dd=${EPOCHSECONDS}; wc="$(lynx "http://www.thefreedictionary.com/_/WoD/rss.aspx" -dump -width 800   -force_empty_hrefless_a|tr "<>/" "\n"|grep -e "Definition"|cut -f2 -d" " --complement | tee ~/logs/words/dd$dd.log | wc -l; )"; for i in $(seq $wc;); do ww=($(sed -n ${i}p ~/logs/words/dd$dd.log)); printf %b "${ww[*]}" > ~/logs/words/w_${ww}.log; done; }; 
