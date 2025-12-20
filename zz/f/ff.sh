# ripgrep->fzf->vim [QUERY]
# unalias ff; 
ff() { 
local IFS=$'\n'; 
hash rg 2>/dev/null||$sudo apt install ripgrep; 
hash bat 2>/dev/null||$sudo apt install bat; 
RELOAD='reload:rg --column --color=always --smart-case {q} || :'
OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then micro {1} +{2}; 
else micro {+f}; fi'; 
old="$PWD"; 
dd=($(
#cd $HOME/logs/appa 2>/dev/null; 
		fzf -i --cycle --disabled --ansi --multi \
      --bind "change:$RELOAD" \
      --bind "start:$RELOAD" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind "q:abort" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat -p --color=always --highlight-line {2} {1}' \
      --preview-window '<70(9),<80(up,2,wrap)' \
))||(printf %b "nope\n\n"; return 1; )|| return 0; 
cd $old; 
echo; 
pp=($(for i in ${dd[*]}; do 
printf %b "${i/:*/}\n"; 
done; )); 
printf %b "\e[96m --\e[0m Install: \n\n${pp[*]}\n"; 
printf %b "\n\n\n\n\n\e[4A \e[0m\e[96m--\e[0m Continue? ";
printf %b "\e[0\[\e[2mY\e[0m/\e[2mn\e[0m]";
read -n1 -rsp ' ' 'yno';
if [[ "$yno" == "${yno#[Nn]}" ]]; then \
        printf %b "\e[92m OK\e[0m \n\n";
        $sudo apt update 2> /dev/null | bat -ppflc --theme Dracula;
        $sudo apt upgrade -y 2> /dev/null | bat -ppflc --theme Dracula;
        $sudo apt install -y ${pp[*]} 2> /dev/null | bat -ppflc --theme Dracula;
        $sudo apt autoremove -y 2> /dev/null | bat -ppflc --theme Dracula;
else ( printf %b "nope\n\n";
return 1 ); fi; 
echo;       # --query "$*"
}
      # --bind "enter:become:$OPENER" \

      # --bind "start:$RELOAD" 
