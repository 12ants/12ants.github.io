


rs() {
printf "\e[A\e[2K\e[7m rsync reciever: \e[0m\n"; 
rsto="$(ls $ants/sh/config/ssh|fzf --margin 0,12,0,12 --border rounded --preview 'cat $ants/sh/config/ssh/{}' --preview-window border-left  --info=inline --height='~22%' --scroll-off=12 --header '-- ssh to: --')"; 

printf "\e[A\e[2K\e[7m rsync files: \e[0m\n"; 
rs=("$(ls -ptr|grep -v '/'|fzf --height='~42%' --scroll-off=12 -m --info=inline --margin 0,12,0,12 --border rounded --preview 'cat {}' --preview-window border-left)"); 
printf "\n${rs[*]}\n\n"; 
printf "\e[A\e[2K\n -- to: \t"; 
[ "${rsto}" = "new" ] && read -rep " " -i "192.168.0.10" 'rsto'; 
read -rep " " -i "$rsto" 'rsto'; 
printf " -- user: \t"; 
read -rep " " -i 'aa' 'rsuser'; 
printf " -- folder: \t"; 
read -rep " " -i '~/rs/' 'rsfold'; 
rsync -a --info=name1 ${rs[*]} ${rsuser}@${rsto}:${rsfold} ; 
printf "\n\e[7m$rsuser@$rsto:$rsfold\e[0m\n";
ssh "$rsuser"@"$rsto" 'printf "\e[35m$HOME'"${rsfold/\~/}"'\n\e[0m"; ls -ptcr '"$rsfold"'|tail -n12'
} 



#fzf --margin 0,12,0,12 --height ~12% --preview "cat {}" --border rounded
