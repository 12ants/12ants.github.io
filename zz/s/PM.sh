
fs=($(df -H | grep -v "tmpfs")); printf %b "${fs[*]}" | column --table --table-columns-limit 5 --output-width 2 --output-separator ' | '
