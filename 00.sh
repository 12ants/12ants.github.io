#/bin/bash
## Install-script for Ubuntu/Debian systems
## visit https://12ants.github.io for credits
rootgit=12ants.github.io;
if [ $UID != 0 ]; then echo -e " \n\n\t This script must be run as root... try command: [ sudo -s ] \n\n " 1>&2; exit 1; fi; ## ROOT-CHECK

## ADDING COLOR-CODES -- (Need to run inside other command.)
export bold=$(tput bold) dim=$(tput dim) so=$(tput smso) noso=$(tput rmso) rev=$(tput rev) re=$(tput sgr0) normal=$(tput sgr0) \
redb=$(tput setab 1) greenb=$(tput setab 2) yellowb=$(tput setab 3) blueb=$(tput setab 4) purpleb=$(tput setab 5) cyanb=$(tput setab 6) \
grayb=$(tput setab 7) red=$(tput setaf 1) green=$(tput setaf 2) yellow=$(tput setaf 3) blue=$(tput setaf 4) purple=$(tput setaf 5) \
cyan=$(tput setaf 6) gray=$(tput setaf 7) white=$(tput setaf 7 bold) pink=$(tput setaf 5 bold) darkblue=$(tput setab 5 bold) blink=$(tput blink) \
left2=$(tput cub 2) up1=$(tput cuu1) c75="  ---------------------------------------------------------------------------"; clear; echo ; c2="$cyan --$re";
## WELCOME-SCREEN
inst="/home/00/"; mkdir -p $inst; chmod 775 $inst; cd $inst; clear; echo ;
echo -e "
  $c2  Welcome to$pink Linux-tweaks$re by$green 12ants.com$re
  $c2  Please choose preferred actions \n \n ";
read -ep "  $c2  Root repo for install-files: [Press Enter to continue] " -i "${rootgit}" rootgit;
read -ep "  $c2  update system? [y/n]: " -i "n" "upsys";
if [ $upsys == y ]; then echo "updating..."; apt update; apt -y upgrade; apt -y install curl wget; clear; echo ""; echo ""; else echo ok ; fi; 
clear;
##############################
######## INSTALLER ###########
######################
echo -e "\n\n\t $c2 $pink Software installation$re -- \n\n"
read -ep  "  $c2  install$green cloudpanel? $re         [y/n]: " -i "n" "cloudpanel"
read -ep  "  $c2  install$green hestia-web-server? $re  [y/n]: " -i "n" "hestia"
read -ep  "  $c2  install$green guake? $re              [y/n]: " -i "n" "guake"
read -ep  "  $c2  install$green custom-grub? $re        [y/n]: " -i "n" "grub"
read -ep  "  $c2  install$green sudo-color? $re         [y/n]: " -i "n" "auto"
read -ep  "  $c2  install$green 4xfce GUI-OS? $re       [y/n]: " -i "n" "xfce"
read -ep  "  $c2  install$green login-screen? $re       [y/n]: " -i "n" "login"
read -ep  "  $c2  install$green webmin? $re             [y/n]: " -i "n" "webmin"
echo -e "$purple ---------------------------------------------$re "
read -ep "  $c2 $yellow begin installation? $re         [y/n]: " -i "n" "continue"
  
if [ $continue == y ]; then echo -e "\n\n\t --$cyan OK$re -- \n\n"; else exit 1; fi; 
## REMEMER TO CHANGE VAR-NAMES.

##
if [ $cloudpanel == y ]; then echo "installing cloudpanel";
wget -O cloudpanel.sh https://installer.cloudpanel.io/ce/v2/install.sh && bash cloudpanel.sh;
else echo "OK"; fi; cd $inst;

## 
if [ $hestia == y ]; then echo "installing hestia";
wget -O 12hestia.sh https://raw.githubusercontent.com/hestiacp/hestiacp/release/install/hst-install.sh; bash 12hestia.sh;
else echo "OK"; fi; cd $inst;

##
if [ $guake == y ]; then echo "installing guake";
apt -y install guake;
else echo "OK"; fi; cd $inst;

##
if [ $grub == y ]; then echo "installing grub";
wget -O 12grub.sh $rootgit/sh/grub.sh; bash 12grub.sh;
else echo "OK"; fi; cd $inst;

##
if [ $auto == y ]; then tput blink ; echo "installing auto-sudo";
wget -O auto-sudo.sh $rootgit/sh/auto-sudo.sh; bash auto-sudo.sh; 
else echo "OK"; fi; cd $inst;
  
##
if [ $xfce == y ]; then tput blink ; echo "installing xfce";
clear; echo -e "\n\t -- This might take a while \n\t "
apt install -y -qq xfce4-session xfce4-goodies xfce4-panel alsa synaptic xinit luakit firefox guake    #  minimal desktop env
echo -e "\v\t Type [ startx ] to execute \v\v"
else echo "OK"; fi; cd $inst;

##
if [ $login == y ]; then echo "installing login-screen";
wget -O login.sh $rootgit/sh/login.sh; bash login.sh;
else echo "OK"; fi; cd $inst;

##
if [ $webmin == y ]; then echo "installing webmin";
wget https://download.webmin.com/devel/tarballs/webmin-current.tar.gz;
tar -xf webmin-current.tar.gz --strip-components=1; 
./setup.sh /usr/local/webmin;
else echo "OK"; fi; cd $inst;


##
## end - reboot
echo -e "
  $c2 $green https://12ants.github.io/$re $c2$re
\v  $c2 $pink your ip: $(hostname -I) $re $c2$re
\v  $c2  enjoy!$re $c2$re \v\v"
echo -e "\v\v"; read -t 22 -ep "  $c2  reboot now?: " -i$green "yes" "reboot"$re;
if [ $reboot == yes ]; then echo rebooting...; reboot;
else echo -e "\v\v  $c2$re  OK \v\v"; fi; echo -e "  $c2$pink \v\v enjoy! \v\v\v\v"

