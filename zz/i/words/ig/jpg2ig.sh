#!/bin/bash
jpg2ig() { 
igfolder="$HOME/logs/words"; igurl="https://aa.aeniks.com"; 
igword="$(ls -t1 $igfolder/wordimg|grep -e ".jpg"|head -n1|sed "s/\.jpg//g")"; 
igwords="$(sed -n 4p $igfolder/wordlog/$igword.log)"
####
sed -e "/url:/curl:\ \'${igurl}/wordimg/${igword}.jpg\'," -e "/caption:/ccaption:\ \'${igwords}\'," ${igfolder}/index_template.js > ${igfolder}/index.js; 
sleep 2; 
cd $igfolder; node index.js; 
}; 
jpg2ig; 
