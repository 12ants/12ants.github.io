#!/bin/bash 
reset; sleep 1;
bash; tput indn $((LINES-4)); tput cuu $((LINES-9)); echo -e "\n\n\t\t$(tput blink) ¯\(ツ)/¯$(tput sgr0) ";
alias "ee"='echo '; export bold=$(tput bold) dim=$(tput dim) so=$(tput smso) noso=$(tput rmso) rev=$(tput rev) re=$(tput sgr0) normal=$(tput sgr0) \
redb=$(tput setab 1) greenb=$(tput setab 2) yellowb=$(tput setab 3) blueb=$(tput setab 4) purpleb=$(tput setab 5) cyanb=$(tput setab 6) \
grayb=$(tput setab 7) red=$(tput setaf 1) green=$(tput setaf 2) yellow=$(tput setaf 3) blue=$(tput setaf 4) purple=$(tput setaf 5) \
cyan=$(tput setaf 6) gray=$(tput setaf 7) white=$(tput setaf 7 bold) pink=$(tput setaf 5 bold) darkblue=$(tput setab 5 bold) blink=$(tput blink) \
left2=$(tput cub 2) up1=$(tput cuu1) 
export dddd=$(echo -e ""$pink"--------------------------------$re") c2=""$cyan"--"$re""; ants="$_"; ll=$(echo -e " \t "); 
if [ $UID != 0 ]; then echo -ne "\n\n\t This script must be run as root... try command: [ sudo -s ]\n" 1>&2; read -e "K"; fi;
sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf 2>/dev/null;
tf() {
tput setaf $((RANDOM%14+1));
}
tb() {
tput setab $((RANDOM%14+1));
}
tput civis; tput sgr0; 
pro() {
$1 $2 $3 $4 &>./x & disown; tput cuu1; PROC_ID=$!; while kill -0 "$PROC_ID" &>/dev/null; 
do for X in "[        ]" "[$(tf)=$re       ]" "[$(tf)=$(tf)=$re      ]" "[$(tf)=$(tf)=$(tf)=$re     ]" "[$(tf)=$(tf)=$(tf)=$(tf)=    $re]"  \
"[ $(tf)=$(tf)=$(tf)=$(tf)=   $re]" "[  $(tf)=$(tf)=$(tf)=$(tf)=$re  ]" "[   $(tf)=$(tf)=$(tf)=$(tf)= $re]" "[    $(tf)=$(tf)=$(tf)=$(tf)=$re]" \
"[     "$(tf)"=$(tf)=$(tf)=$re]" "[      "$(tf)"=$(tf)="$re"]" "[       $(tf)=]" "[        ]" "[        ]" "[        ]"; 
do echo -e "    $dim[$(tb)  $re$dim]$re "$c2" Executing $rev $1 $2 $3 $4 $re $c2$c2$c2$c2$c2"; tput cuu1; tput sgr0; echo -e "\t\t\t\t\t $X"; tput cuu1; sleep 0.1; 
tput sc; tput cup $((LINES-4)) 0; echo -e "\t$darkblue $(tail -n2 ./x|head -n1) $re"; echo -e "\t$yellow $(tail -n1 ./x) $re"; tput cuu 2; tput rc; 
done; done; echo -e "\t\t\t\t\t"$dim" [$re  "$green"DONE"$re" $dim ]$re "; tput cnorm; rm ./tmp &>/dev/null;
}
echo -e "\t $dddd\n\t Welcome to$cyan 12ants$re bash-improver! \n\t $dddd"; 
read -n1 -ep "$ll""$c2"" Do you wish to proceed? "$dim"["$re$bold"Y"$dim"/"$re$bold"n"$re$dim"] $re" "yn"; 
if [ "$yn" != "${yn#[Nn]}" ]; then echo "$c2 nope";exit 0; else 
echo "$ll$c2 $c2 $c2 $c2 $c2 $c2 $c2 $c2 $c2 $c2 $c2"; fi; prompt='Upgrade apt? \t   '; echo -e "\t $re$c2 $prompt $white$dim["$re$bold"Y$dim/"$re$bold"n$dim]$re "; read -n1 yn_upgrade_apt; 
prompt='Clone Ants? \t   '; echo -e "\t $re$c2 $prompt $white$dim["$re$bold"Y$dim/"$re$bold"n$dim]$re "; read -n1 yn_clone_ants; 
if [ "$yn_clone_ants" == "${yn_clone_ants#[Nn]}" ]; then echo -e "\t $c2 OK"; 
read -ep "$ll$c2 Folder for$cyan$bold Github? $re" -i "$PWD/gh/" "gh"; export gh="$gh"; ####
pro sudo apt install git 2>/dev/null; 
mkdir $gh -p -m 775; sudo chown $SUDO_USER: $gh; cd $gh; mkdir ants -p -m 775; #################
cd $gh/ants; ants="$gh/ants"; echo;echo; #######################################################################
pro='git stash'; pro; sleep 1; pro='git pull'; pro; sleep .1; cd ..; sleep .1; echo -ne " $re ";
pro git clone "https://github.com/12ants/ants"; pro; cd ants 2>/dev/null; sleep .1; #############################
sleep 0.5; else echo "nope"; fi;
sudo chown $SUDO_USER: $ants -R; read -n1 -ep "$ll""$c2"" Install Improvments? "$dim"["$re$bold"Y"$dim"/"$re$bold"n"$re$dim"] $re" "yn"; 
if [ "$yn" != "${yn#[Nn]}" ]; then echo "$c2 nope"; return 2>/dev/null; else echo "$ll$c2 OK";
cd $ants; tput dim; sudo chown $SUDO_USER: $ants -R 2>/dev/null
cp $ants/sh/ssss.sh /bin/ssss -bv 2>/dev/null
if [ "$yn_upgrade_apt" == "${yn_upgrade_apt#[Nn]}" ]; then echo -e "\t $c2 OK"; 
pro sudo apt update; pro sudo apt -y upgrade; pro sudo apt -y autoremove;
else echo "nope"; fi;
cd $gh/ants/; pwd; ls -a; sleep 2; echo;echo -e "\t Opening github-script...";echo;echo;  sleep 1; 
. $ants/ants.sh; 
return 2>/dev/null; break 2>/dev/null; echo gg;
