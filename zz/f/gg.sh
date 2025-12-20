gg() { 
local IFS=$' \n'; 
gmenu() { 
local ops=($2); [ "$2" ]|| local ops=(*);     
local prompt="$1" index="0" cur="0" count="${#ops[@]}" esc=$(echo -ne "\e");     
printf "\e[?25l\e[96m --\e[0m $prompt \n"; while true; do local index="0"; 
for o in "${ops[@]}"; do if [ "$index" == "$cur" ]; 
then echo -e " > \e[7m $o \e[0m"; else echo -e "    $o  "; fi; (( index++ )); done; 
read -srn1 key;   if [[ $key == A ]]; then (( cur-- )); (( cur < 0 )) && (( cur = 0 )); 
else if [ "$key" = B ]; then (( cur++ )); (( cur >= count )) && (( cur = count - 1 )); else 
if [[ $key == "" ]]; then break; else if [[ $key == "q" ]]; then return 1; break; fi; fi; fi; fi; 
echo -en "\e[${count}A"; done; printf -v sel "${ops[$cur]}"; 
printf "\e[?25h\n \e[7m $sel \e[0m\n\n"; } 

ggoogler() { 
[ -n "$1" ]&& printf -v gss "$([ -n "$1" ]&& for i in $@; do printf "$i+"; done; )"; 
printf -v "gss" "${gss:0:(-1)}"; 
printf %b "\n\n\n\n\n\n\e[?25h\e[6A\e[0m\n"; 
read -rep " $(printf %b "\e[96m --\e[0m "; )google: $(printf %b "\e[92m\v\e[A")" -i "$gss" "gss"; 
printf -v "gs" "https://google.com/search?q=${gss// /+}"; echo $gs; echo; 
gmenu "open with:" "termux-open ${www_cli} ${www_display} ${WWW_BROWSER} ${BROWSER} firefox w3m" && $sel $gs; 
printf %b "\e[?25h\nv=\$gs\n$gs\n"; }; 
printf %b "\e[?25h"; 
ggoogler "$@"; 
}; 

