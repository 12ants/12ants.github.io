printf %b "s[$(trap -l|tr -d " "|tr -s ")\t\n" "];"|sed -e "s/\;/\;\ns[/g")" |sed -e s/\]/\]\=\"/g -e s/\;/\"\;/g|head -n-1|tr -d "\n\+\-"
