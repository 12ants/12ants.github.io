
dl() { printf %b "\n"; [ $1 ] && dl="$@"||read -ep 'dl: ' 'dl'; yt-dlp -P "/storage/emulated/0/Movies" --restrict-filenames -o "%(title)s.%(ext)s" "${dl}" && termux-notification -c "$(ls -t /storage/emulated/0/Movies|tail -n1)" --action "termux-open $(ls -t /storage/emulated/0/Movies/|tail -n1)"; }; 
