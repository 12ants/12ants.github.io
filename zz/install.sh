#!/bin/bash
## installer 
install88() {
hash sudo 2>/dev/null && sudo="sudo"; 
hash sudo 2>/dev/null || alias sudo=' '; 
[ "$PREFIX" ] && unset sudo; [ "$(id -u)" = 0 ] && unset sudo && unalias sudo; 
mkdir -p ${HOME}/{tmp,logs,gh,backup,.config,.safe,.cache,.local/bin,bin,img,dl} 2>/dev/null;
tmp="$HOME/tmp" time=$(date +%y_%m_%d_%H_%M_%S) bu=$HOME/backup; 
unset -v _yno_prompt _yno ny p pp yy; 
for i in $(seq 1 22); do unset -v "pp$i"; done; 
local IFS=$'\n\t ' start="$HOME/.config/12/zz" re='\e[0m' bold='\e[1m' height="$(stty size|cut -f1 -d" ")" width="$(stty size|cut -f2 -d" ")" yno='\e[0m[\e[2mY\e[0m/\e[2mn\e[0m]' c2='    \e[0m\e[36m--\e[0m' uu="60" enter='\e[\e[0m [\e[2mENTER\e[0m] to accept or [\e[2mq\e[0m]\e[2mto Quit \e[0m' x="2>/dev/null" yy="1" sl=".1"; 
#####
printf %b "\x1b[1 q"; ######### cursor = block 
printf %b "\x1b]12;#ff44bb"; ## cursor = pink 
printf %b "\x1b]11;#04000f"; ## background = darkblue 
#####
#####
p1() { p2=" ${@}"; for i in $(seq ${#p2}); do sleep $sl; printf %b "${p2:${i}:1}"; done; }; 
p2() { printf %b "$@"; }; 
#####
#####
for i in $(seq $((height))); do printf %b "\n"; done; 
p2 "\e[H\e[J"; sleep .2; echo; sleep .2; echo;
p1 "       hello... "; id -un; 
sleep 1; echo; sleep .2; echo; sleep .2; sl="0.04"
#####
#####
_ok() { p2 "\e[42G\e[0;1m [\e[0;92m"; p1 "OK"; p2 "\e[0;1m]"; p1 " "; p2 "\n"; 
[ "$ny" = "q" ] && return 1; }; 
##
_yno() { yno='\e[0m[\e[2mY\e[0m/\e[2mn\e[0m]'; [ "$1" ] && ny=${1}; printf %b "\e[?25h\e[45G\b\b\b\b\b\b\b\b$yno "; 
printf -v _yno_${1} "false"; read -rsn1 ny; [[ -z $ny || $ny = y ]] && printf -v "pp$((yy++))" %b "ok" && printf -v _yno_${1} "true" || unset -v pp$((yy++)); _ok; [[ $ny = q ]] && printf %b "\e[?25l\n\n" && return 1; }; 
##
_link() { ln -s $@ 2>/dev/null; }; 
_backup() { mv -fb --suffix="_${time}" $@ -t $bu &>/dev/null; }; 
_newcolor() { printf %b "\e[38;5;$((uu++))m"; sleep .02; }; 
_prompt() { [[ "$ny" = "q" ]] && return 1; p2 "$c2 "; p1 "$@"; _yno prompt; if [[ $_yno_prompt == true ]]; then _newcolor; else return 1; fi; }; 
_where() { p2 "$c2 "; p1 "where to? "; read -ei "$HOME/" "hstart"; start="${hstart}/12"; sleep .2; }; 
# export start="${start/\/\///}"; 
#####
#####
########################################
########################################
#####
_prompt "update system? "; 
#####
_prompt "install basic apps? "; 
#####
_prompt "download config-files? " && _where && _prompt "install config-files? "; 
#####
######
_prompt "login to github? " && p2 "$c2 " && p1 "password? " && read -rs "pwgh" && echo;  
#####
_prompt "install extras? " && p2 "$c2 " && p1 "password? " && read -rs "pw"; 
########################################
#####
[ "$ny" = "q" ] && echo && echo && return 0; 
[ "${!pp*}" ] && printf %b "\n\n\e[A$c2 ${!pp*} " && _prompt "ok? " && printf %b "\n\n\e[A$c2 installing selections ... \n-\e[222b\n" || ny=q; 
[ "$ny" = "q" ] && echo && echo && return 0; 
####
if [ "$pp1" ]; then printf %b "\n$c2 updating apts ...\n\n"; _newcolor; $sudo apt update; _newcolor; $sudo apt upgrade -y; printf %b "\n$c2 apts updated! \n"; fi; 
##############################
##############################
if [ "$pp2" ]; then printf %b "\n$c2 installing apts ... \n"; 
for i in $(command ls -1 "$start/install/ap"); do rr="$(shuf -zn1 -i 12-88)"; printf %b "\ec\e[0m -- \e[48;5;${rr}m ${i} \e[0m --\n\e[38;5;${rr}m "; 
command -v "$i" 2>/dev/null || "$sudo" apt install -y "$i"; done; 
printf %b "\n$c2 apts installed ...\n"; fi; 
##############################
##############################
if [ "$pp3" ]; then printf %b "\n$c2 downloading config files ...\n"; 
# _backup "$start"; _newcolor; 
hash git 2>/dev/null || $sudo apt install -y git 2>/dev/null; 
git clone https://github.com/12ants/12ants.github.io.git $start; 
cd "$start"; 
git config remote.origin.url git@github.com:12ants/12ants.github.io.git; 
cd $OLDPWD; 
printf %b "\n$c2 config files downloaded! \n"; fi; 
##############################
##############################
if [ "$pp4" ]; then 
printf %b "\n$c2 installing config files ...\n"; 
_backup $HOME/.inputrc; _newcolor; _link $start/c/inputrc $HOME/.inputrc; _newcolor; confolders=($(ls -1p $HOME/88/c|grep "/")); 
for q in ${confolders[*]}; do 
mkdir -p $HOME/.config/$q 2>/dev/null; _backup $HOME/.config/$q/*; _newcolor; 
ln -s $start/c/$q/* -t $HOME/.config/$q/ 2>/dev/null; sleep .2; printf %b "\n\e[0m"; p1 "updated"; _newcolor; printf %b " $q"; done; _newcolor; printf %b "${PATH}:${HOME}/.local/bin" > $HOME/.config/path.sh; chmod 775 $HOME/.config/path.sh; _newcolor; printf %b "\n\e[0m"; p1 'added PATH to ~/.config/path.sh '; printf %b "\n$c2 config files installed! \n"; fi; 
##############################
##############################
if [ "$pp5" ]; then printf %b "\n$c2 logging in to github ...\n"; 
##
ghuser="$(id -nu)"; 
ghmail="$(id -nu)@$(hostname)"; 
gh_aeniks="$start/c/gpg/gh_aeniks.conf.gpg"; 
## ibstall ssh
for ss in {ssh,openssl,openssh-server,gh,git,gnupg} ; do hash "$ss" 2>/dev/null || "$sudo" apt install -y "${ss}" 2>/dev/null; done; 
##
gpg --quiet --passphrase "${pwgh}" -o "$HOME/.safe/gh_aeniks.log" -d "$gh_aeniks" 2>/dev/null; 
##
gh auth login --with-token < "$HOME/.safe/gh_aeniks.log"; sleep .2; _ok; 
gh auth status; _ok; 
git config --global user.name $ghuser; 
git config --global user.email $ghmail; 
git config --global init.defaultBranch main; 
##
[ -r "$(ls -1 $HOME/.ssh/*.pub 2>/dev/null|head -n1)" ] || ssh-keygen -N '' -f $HOME/.ssh/id_ed25519; 
chmod 600 $HOME/.ssh/*; chmod 644 $HOME/.ssh/*.pub; 
##
gh config set git_protocol ssh; 
gh ssh-key add $HOME/.ssh/id_ed25519.pub; 
printf %b "\e[96m\u990 \e[0m"; 
ssh -T git@github.com; printf %b "\n"; 
##
cd $start; git config remote.origin.url git@github.com:aeniks/88.git 2>/dev/null; 
cd $OLDPWD; 
##
printf %b "\n$c2 logged in to github! \n"; 
##
fi; 
# gpg --quiet --pinentry-mode loopback -o "$HOME/.safe/gh_aeniks.log" -d "$gh_aeniks" 2>/dev/null; 
##############################
if [ "$pp6" ]; then printf %b "\n$c2 installing extras ...\n"; gpgs=($(ls -1 $start/c/gpg/*.gpg)); for i in ${gpgs[*]}; do basename ${i/.gpg/}; printf %b "\n----\n"; gpg --quite -o $HOME/.safe/$(basename ${i/.gpg/}) --passphrase ${pw} -d ${i}; done; printf %b "\n$c2 extras installed ...\n"; fi; 
##############################
##############################
##############################
printf %b "\n\n\n\n\e[4A\n\e[0m -- \e[48;5;196m DONE \e[0m --\n\n"; 
}; 
####
####
install88; 
##
## for i in $(seq $((height / 2))); do printf %b "\e[38;5;$((RANDOM%16 + 111))m$i\n"; sleep .01; done; for i in $(seq $((height / 2 - 5))); do printf %b "\e[K\e[A\e[2K"; sleep .02; done; printf %b "\e[?25l"; 
## unalias p1 p2 2>/dev/null; p1() { p2=" ${@}"; for i in $(seq ${#p2}); do sleep .04; printf %b "${p2:${i}:1}"; done; }; p2() { printf %b "$@"; }; 
##
##
