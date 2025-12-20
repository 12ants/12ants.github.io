#!/bin/bash
## nstaller

aapp=(\
fzf \
net-tools \
ffmpeg \
tmux \
lf \
bat \
chafa \
openssh \
bash-completion \
neofetch \
micro \
git \
aria2 \
aria2c \
gh \
mosh \
ripgrep \
jp2a \
mediainfo \
exiftool \
lsd \ 
nmap \ 
); 


# $sudo apt install -y fzf net-tools ffmpeg tmux lf bat chafa openssh bash-completion neofetch micro; 
# printf %b "\n\t\e[0m[\e[92mok\e[0m]\e[95m\n"; 

# printf $b "\n\e[0;2m-\e[222b\n-----\e[0;1m\e[38;5;$((i + 88))m ${aapp[i]} \e[0;2m-\e[222b\n-\e[222b\n\e[0m"; 

[ -z $PREFIX ] && [ $UID -gt 0 ] && sudo=sudo; 
####
printf %b "\e[G -- apps to be installed --\n --------------------------\n"; 
for i in ${!aapp[*]}; do sleep .2; 
printf %b "\
\e[38;5;$((6 * i))m${aapp[i]}\t\t\
\e[22G\b\b$((6 * i))\n"; done; 
echo; sleep .2; echo; sleep .2; echo; sleep .2; echo; sleep .2; 
####
printf %b "\e[5A\n\e[2m --\e[0m hello "; sleep .2; 
printf %b "\n\e[2m --\e[0m install apps\e[2m? "; sleep .2; printf %b " \e[0m[\e[2mY\e[0m/\e[2mn\e[0m] "; 
read -sn1 "ny"; if [ -z $ny ]; then 
printf %b "  \e[0m[\e[92mok\e[0m]\e[96m\n"; sleep .2; 
$sudo apt update; 
printf %b "  \e[0m[\e[92mok\e[0m]\e[95m\n";
$sudo apt upgrade -y; 
printf %b "  \e[0m[\e[92mok\e[0m]\e[96m\n";
# printf %b "\n\n-\e[222b\e[$((COLUMNS / 2 - 5))D[\e[92mok\e[0m] -----\n\n"; 
# printf %b "\n\n-\e[222b\e[$((COLUMNS / 2 - 5))D[\e[92mok\e[0m] -----\n\n"; 
####
for i in ${!aapp[*]}; do 
####
####
sleep .1; printf %b "\n"; sleep .1; printf %b "\n"; 
printf %b "\e[0;2m-\e[222b\e[$((COLUMNS/2+${#aapp[i]}/2+2))D\e[0;1m[\e[7;38;5;$((i + 12 * 2))m${aapp[i]}\e[0;1m]\e[2m\n\e[38;5;$((i + 19 + i))m";
####
$sudo apt install -y ${aapp[i]}; 
####
printf %b "\e[0;2m-\e[222b\e[$((COLUMNS / 2+4-1))D\e[0;1m[\e[0;1;92mok\e[0;1m]\e[0";
sleep .1; printf %b "\n"; sleep .1; printf %b "\n"; 
####
####
####
####
done; 
else printf %b "\t\e[91m  ok\e[0m  \n\n"; return 0; fi; 
printf %b "\n\n\e[A ----- apps installed -----\n\n -- [Y/n] \n\n"; 
read -sn1 "kk"; [ -z $kk ] && \
printf %b "\e[92m ok\n" ||
printf %b "\e[91m ok\n";
printf %b "gg\n"; 







# printf %b "\e[0;2m-\e[222b\e[$((COLUMNS/2+${#aapp[i]}/2+1))D\e[0;1m[\e[0;1;92m${aapp[i]}\e[0;1m]\e[0\n";
# 
# # printf %b "\n\e[0;2m-\e[222b\e[$((COLUMNS / 2 + ${#aapp[i]} / 2 + 8))D \e[0;1m[\e[0;1;92m${aapp[i]}\e[0;1m] \e[0\n\n";
# 
# $sudo apt install -y ${aapp[i]}; 
# printf %b "\e[0;2m-\e[222b\e[$((COLUMNS / 2 + 4))D \e[0;1m[\e[0;1;92mok\e[0;1m] \e[0\n\n"; 
# 
