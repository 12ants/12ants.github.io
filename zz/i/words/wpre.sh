#!/bin/bash
## create fs
wordfolder="$HOME/logs/words"; 
mkdir -m 775 -p \
"$wordfolder/wordlog" \
"$wordfolder/tmp" \
"$wordfolder/wordimg/story" \
"$wordfolder/wordimg/post" \
"$wordfolder/up" \
2>/dev/null; 
