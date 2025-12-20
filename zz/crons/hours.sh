
notvolume="$(termux-volume|grep -e "system" -A1|grep -e "[[:digit:]]" --only-matching;)"; termux-volume system 4; termux-tts-speak -s SYSTEM "$(date +%H-%M)"; termux-volume system $notvolume; 
