#!/bin/bash 
wordd() { mkdir -m 775 -o ~/logs/words 2>/dev/null; dd=${EPOCHSECONDS}; wc="$(lynx "http://www.thefreedictionary.com/_/WoD/rss.aspx" -dump -width 800 -force_empty_hrefless_a|tr "<>/" "\n"|grep -e "Definition"|cut -f2 -d" " --complement | \
tee ~/logs/words/dd$dd.log | wc -l; )"; 
for i in $(seq $wc;); do ww=($(sed -n ${i}p ~/logs/words/dd$dd.log)); 
printf %b "${ww[*]}" > ~/logs/words/w_${ww}.log; 
printf %b "<!DOCTYPE html><html>
<head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta name='viewport' content='width=device-width, initial-scale=1.0'>
<title>word of the day - $ww</title>
<style>body {margin:0;width:100%; overflow-x:hidden; 
font-family:monospace; font-size:clamp(1.6vmin,2vmin,.182em); 
text-align:center;padding-top:clamp(6vh,22vh,8em);
background:rgb($((RANDOM%88 + 8)),$((RANDOM%88 + 8)),$((RANDOM%88 + 8)));
margin-top:calc(12vh - 9ch);}</style></head>
<body><pre>" > ~/logs/words/${ww}.html; 
(figlet -w 400 -o -f Roman "$ww"|bat -ppfljava --theme DarkNeon; printf %b "\e[6A" ; printf %b "${ww[*]:2}\n"|tr "\n" " "|bat -ppf --language d --theme Visual\ Studio\ Dark+ ; printf %b "\n\n${ww[1]}\n"|bat -ppfll --theme DarkNeon)|tee ~/logs/words/w_${ww}_f.log | aha -x -n -t "word of the day - $ww" >> ~/logs/words/${ww}.html; 
printf %b "</pre></body></html>" >> ~/logs/words/${ww}.html; 
mv -f ~/logs/words/w_${ww}_f.log ~/logs/words/w_${ww}.log -t ~/tmp; done; 
mv -f ~/logs/words/dd$dd.log -t ~/tmp; 
}; 
wordd; 
