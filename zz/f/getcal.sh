getcal() { 
[ -e $PREFIX/bin/wget ] || $sudo apt install -y wget; [ -e $HOME/logs/calendar.json ]||wget -qL "https://script.google.com/macros/s/AKfycbwSft4XmNq-lCW38uuBjihWM8pKMGrm-1uDmwusW7uksz0uN3WIEobzOt-0NQUgDOASqQ/exec" -O $HOME/logs/calendar.json; cat $HOME/logs/calendar.json | tr "+}{," "\n\n" | grep -v "description" | grep -w -A2 "summary" | sed --regexp-extended 's/-.*T/~/g' | cut -f2- -d":" | cut -f2 -d"~" | tr -s '"\n\-' "\t \n" | column --table --output-separator "  " --table-columns-limit 6 --table-hide 5 | batcat -ppfld; 
}


