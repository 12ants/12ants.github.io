function url () { 

unset -v uhl; 

url=($(for i in $(tmux list-panes|cut -c1); 
do tmux capture-pane -Jpt$i; done | grep -oE '(http|https?):\/\/.*[^>]' 2> /dev/null || return 1)) || return 0; 

local IFS=$'\n'; 

[ $url ] && uurl=($(printf %b "${url[*]}" |tr -s " ;\"\'" "\n"|grep -E "http*"|uniq)); 

uhl="$(printf %b "${uurl[*]}"|wc -l)"; 
uh=$(printf %b "${uurl[*]}"|wc --max-line-length); 

urla=($(printf %b "${uurl[*]}" | \
fzf --tmux "center,$((uh + 6)),$((uhl + 4))" --bind 'enter:print-query' --disabled --info inline:" kk " --bind 'focus:replace-query')) || return 2; 
printf %b "\n${urla[*]}\n"; 
xdg-open $urla || termux-open-url $urla; 

}; 
url; 
