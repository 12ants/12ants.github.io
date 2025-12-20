. $HOME/88/s/sigt.sh; for i in ${!s[*]}; do trap "echo -ne '\n\e[0;2m[\e[0;1;38;5;1${i}m$i\e[0;2m]\e[0;1m${s[i]}\e[0;2m\n[\e[0;1;38;5;'"'$(($? + 42))m$?'"'\e[0;2m][\e[0;1m'"'${BASH_COMMAND[*]}'"'\e[0;2m]\e[0m \n' " $i; done; 
####
#### printf %b "s[$(trap -l|tr -d " "|tr -s ")\t\n" "];"|sed -e "s/\;/\;\ns[/g")" |sed -e s/\]/\]\=\"/g -e s/\;/\"\;/g|head -n-1|tr "\n+\-" " _" > $TMPDIR/kk.sh; chmod 775 $TMPDIR/kk.sh; . $TMPDIR/kk.sh; 
