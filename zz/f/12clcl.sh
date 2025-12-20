#!/bin/bash
## clean filenames 
12clcl() { 
local IFS=$'\n' red='\e[91m' green='\e[92m' re='\e[0m' \
dim='\e[2m' q="$(printf %b "\e[0;2m--\e[0m";)"; 
unset filelist new newchange gg; 
## perl function 
#newf() { echo -n $1 | perl -pe 's/[\?\[\]\/\\=<>:;,''"@&\$#*()|~`!{}%+]//g;' -pe 's/[\r\n\t -]+/_/g;'; }; 
newf() { echo -n $1 | tr -d '%&/"" ?@!*[]{}()<>~/$|,:;`=*#\’'; }; 

# perl -pe 's/[\?\[\]\/\\=<>:;,''"@&\$#*()|~`!{}%+]//g;' 
# -pe #'s/[\r\n\t -]+/_/g;'; }; 
## 

files=($(newf $(command ls $@ 2>/dev/null))); 
if [ "$1" = "find" ]; then filelist=($(command ls|fzf));
else 
#if [ ${#1} -gt 2 ]; then 
command ls $@ &>/dev/null||\
(printf %b "\n $q no such file ... \n\n\
try: ["$dim"cleanse find"$re"] to choose from a list of files, \n\
but here is a clean name: $dim$1$re$green >> $re\n\n$(newf $1)\n\n"; 
return 1)||return 1; filelist=($(command ls $@ 2>/dev/null)); 	
filelist=($(command ls 2>/dev/null)); fi; 

#echo nada; return 1; fi; 

printf %b "\n$re$dim-----------------\n$q\e[0m Filenames found:\n$re$dim-----------------\e[1A";
##
ga=($(for i in ${filelist[@]}; do new="$(newf $i)"; if [ '"'"$i"'"' != '"'"$new"'"' ]; 
then printf %b "$re$red$i$re >> \n${green}${new,,}$re\n\n"; fi; done; )); 
for i in ${#ga[*]}; do printf %b "\n\n"; done; 
printf %b "${ga[*]}"
#|tee|command less --clear-screen --quit-if-one-screen --quiet --tilde --dumb --shift=2 -R --use-color --file-size \
#--prompt='.?n?m(%T %i of %m)..?lt..reading lines %lt-%lb?L/%L. :byte %bB?s/%s. .?x- Next\: %x.:?pB%pB\%.. .. .. .. .. [space] to scroll%t, to exit press [q] '; 
####

printf %b "$re\n\n\n\n"; 
printf %b "\e[2A"; 
printf %b "\n$re$dim-----------------\n$q\e[0m OK? ["$dim"Y"$re"/"$dim"n"$re"] \n$re$dim-----------------";
#printf %b " $q Change these filenames? ["$dim"Y"$re"/"$dim"n"$re"]"; 
read -n1 -sp " " "ny"; [ "$ny" ]&& (printf %b "$red nope$re\n\n"; 
return 0; )&& return 0; 
printf %b "$green ok$re\n\n";
echo -e " ok\n "; 
####
gg=($(for i in ${filelist[@]}; do new="$(newf $i)"; 
if [ $i != $new ]; then 
ca=$(printf %b "$i ${new,,}"; ); 
mv $i ${new,,} --interactive; 
fi; done;)); 
####
if [ ${#gg} -gt 2 ]; then echo $gg|\
command less --quit-if-one-screen --wordwrap --redraw-on-quit --quiet --tilde --dumb \
--shift=2 -R --quit-at-eof --use-color --file-size \
--prompt='.?n?m(%T %i of %m)..?lt..reading lines %lt-%lb?L/%L. :byte %bB?s/%s. .?x- Next\: %x.:?pB%pB\%.. .. .. .. .. [space] to scroll%t, to exit press [q] '; 
####
else 
printf %b "$re\n\n\e[7mno operations needed!$re\n\n"; 
return 0; 
fi; 
 }; 

