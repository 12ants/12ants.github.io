#!/bin/bash
## get any word in short definition 
wordget() { word="$@"; [ -z "$1" ] && printf %b "\n\n\e[A-- word:" && read -ep " " "word"; wf="$HOME/logs/words/wf"; mkdir -p -m 775 "$wf" 2>/dev/null; printf %b "\n----\n"; (printf %b "$word\n"; lynx -trim_input_fields -nonumbers -nomargins -trim_blank_lines -width 800 -dump "https://www.dictionary.com/browse/$word"|grep -e 'View synonyms for ' -m1 -A18|grep -ve '(BUTTON)'|sed -e 's/_//g' -e '/( ) /d' -e 1,2d|grep -vE '2. |3. |4. |5. |6. |7. '|grep -E '\[|noun|verb|adjectiv|adverb|1. '|sed -e 's/\ 1.\ //g') > $wf/$word.log1; 
##
(printf %b "$word\n"; sed -n 3p $wf/$word.log1; sed -n 2p $wf/$word.log1; sed -n 4,5p $wf/$word.log1; ) | tee $wf/$word.log; rm $wf/$word.log1; 
##
printf %b "----\n\n\n\n\e[2A-- make jpg? [Y/n] "; read -sen1 "ny"; [ -z "$ny" ] && wordget2jpg; }; 
#!/bin/bash
wordget2jpg() { 
####
local IFS=$'\n\t '; wordfolder="$HOME/logs/words"; wordlog="$wordfolder/wf"; latest="$(command ls -t1 $wordlog|grep -e '.log$'|head -n1)"; ww="$wordlog/$latest"; word="${latest/.*/}"; 
####
mkdir -m 775 -p "$wordfolder/wordlog" "$wordfolder/tmp" "$wordfolder/wordimg" "$wordfolder/up" 2>/dev/null; 
####
#### create file and spacing on top
####
# wordfolder="$HOME/logs/words"; wordlog="$wordfolder/wordlog"; 
latest="$(command ls -t1 $wordlog|grep -e '.log$'|head -n1)"; ww="$wordlog/$latest"; word="${latest/.*/}"; printf %b "  "|ansifilter -M -F "serif" -s 155 > $wordlog/$word.htm; printf %b "  $(sed -n 1p $ww)  "|ansifilter -M -F "serif" -s 260 >> $wordlog/$word.htm; sed -n 3p $ww|tr -s "/" " "|bat -ppflgo --theme Coldark-Dark|ansifilter -c -M -F "code" -s 60 >> $wordlog/$word.htm; sed -n 2p $ww|bat -ppfljs --theme Coldark-Cold|ansifilter -M -F "code" -s 60 >> $wordlog/$word.htm; sed -n 4,6p $ww|fmt -w 42 -g 26|gum style --margin "1 4 1 4" --padding "0 2 2 2"|ansifilter -c -M -s 60 -F "monospace" >> $wordlog/$word.htm; 
####
convert -border 4 -bordercolor black -gravity center pango:"$(cat $wordlog/$word.htm)" $wordlog/$word.jpg 2>/dev/null; echo; 
####
wordw="$(mediainfo --INFORM="Image;%Width%" "$wordlog/$word.jpg")"; 
wordh="$(mediainfo --INFORM="Image;%Height%" "$wordlog/$word.jpg")"; 
wordzp="$(((2999 - wordw) / 2))x$(((2999 - wordh) / 2))"; 
wordzs="$(((2999 - wordw) / 2))x$(((4600 - wordh) / 2))"; 
########
########
hexx="$(pastel random -n1|pastel format hex|col -xb)"; echo; 
convert -border ${wordzp} -bordercolor "$hexx" "$wordlog/$word.jpg" "$wordfolder/wordimg/${word}_post.jpg" 2>/dev/null; echo; 
####
hexx="$(pastel random -n1|pastel format hex|col -xb)"; echo; 
convert -border ${wordzs} -bordercolor "$hexx" "$wordlog/$word.jpg" "$wordfolder/wordimg/${word}_story.jpg" 2>/dev/null; echo; 

########
printf %b "\n----\nhttps://aa.aeniks.com/wordimg/${word}_post.jpg \nhttps://aa.aeniks.com/wordimg/${word}_story.jpg \n----\n"; 
########
printf %b "\n\n\e[A-- open ? [Y/n] "; 
read -sn1 "ny"; [ -z "$ny" ] && xdg-open "$wordfolder/wordimg/${word}_story.jpg";
########
printf %b "\nok\n"
mv "$wordlog/$word.htm" "$wordlog/$word.jpg" -t $wordfolder/tmp; 
}; 
########
# words2jpg; 
########



# printf %b "  "|ansifilter -M -F "serif" -s 150 > $wordlog/$word.htm; \
# printf %b "  $(sed -n 1p $ww)  "|ansifilter -M -F "serif" -s 260 >> $wordlog/$word.htm; \
# sed -n 3p $ww|bat -ppfld --theme GitHub|ansifilter -M -F "code" -s 60 >> $wordlog/$word.htm; \
# sed -n 2p $ww|bat -ppfljs --theme Coldark-Cold|ansifilter -M -F "code" -s 60 >> $wordlog/$word.htm; sed -n 4,6p $ww|fmt -w 48 -g 29|ansifilter -c -M -F "monospace" -s 60 |gum style --padding "0 2 2 6" --align center --border none >> $wordlog/$word.htm; 

####
# |gum style --border hidden --padding "1 5 5 5" --margin "0 1 0 0"|
############
# gum style --margin "0 2 2 2" --border hidden --padding "1 2 1 2" --border-foreground "#666666" "$(printf %b "  "|ansifilter -M -F "serif" -s 20 >> $wordlog/$word.htm; 
# [ "$1" ] && latest="${1/*\//}"; [ "$1" ] && ww="$1"; 
# local IFS=$'\n\t '; 
# cd "$wordlog"; 
####
# gum style --margin "0 2 0 2" --align center --border none "$(sed -n 1p $ww)"


############
############
# convert -border 44 -bordercolor "red" -gravity center pango:"$(sed -n 3p edifice.log | iconv|fmt|col -xb | ansifilter -c -M -F monospace)" eded.jpg; 
####
# convert -border 4 -bordercolor black -gravity center pango:"$(cat $wordlog/$word.htm)" $wordlog/$word.jpg; 
####
# hexx="$(pastel random -n1|pastel format hex|col -xb)"; 
# im=($(mediainfo "$wordfolder/wordimg/$word.2.jpg"|grep -E 'Width|Height'|tr -d "A-z:\t "));
# imh="$((im[1] - im))"; imw="$((im - im[1]))"; [ "$imw" -gt 1 ] && imh=122; 
# $((imh + 222))x$((imw / 2 "+ 222")) 
##
# convert -border 288x400 -bordercolor "$hexx" \
# "$wordlog/$word.jpg" "$wordfolder/wordimg/post/$word.jpg"; 
##
# convert -border 280x1200 -bordercolor "$hexx" \
# "$wordlog/$word.jpg" "$wordfolder/wordimg/story/$word.jpg"; 
# "$wordfolder/wordimg/$word.2.jpg" "$wordfolder/wordimg/story/$word.jpg"; 
##
# printf %b "$wordfolder/wordimg/story/$word.jpg \n$wordfolder/wordimg/post/$word.jpg \n"; 
####
# cp "$wordfolder/wordimg/post/$word.jpg" -t "$wordfolder/up"; 
# cd -; 
# "$wordfolder/wordimg/$word.2.jpg"
# mv "$wordlog/${word}.log" -t $HOME/logs/words/up
####
# iw="$(mediainfo pp.jpg | grep 'Width'|tr -d "A-z:\n\t ")"; ih="$(mediainfo pp.jpg | grep 'Height'|tr -d "A-z:\n\t ")"; 

