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


mkdir -p /home/00/; chmod 775 /home/00; cd /home/00/; clear; echo ;
echo -e "
  $c2  Welcome to$pink Linux-tweaks$re by$green 12ants.com$re
  $c2  Please choose preferred actions \n \n ";
read -ep "  $c2  Root repo for install-files: [Press Enter to continue] " -i "${rootgit}" rootgit;
read -ep "  $c2  update system? [y/n]: " -i "n" "upsys";
if [ $upsys == y ]; then echo "updating..."; apt update; apt -y upgrade; clear; echo ""; echo ""; else echo ok ; fi; 
clear;
##############################
######## INSTALLER ###########
######################
echo -e "\n\n\t $c2 $pink Software installation$re -- \n\n"
read -ep "  $c2  install$green cloudpanel? $re         [y/n]: " -i "n" "cloudpanel"
read -ep "  $c2  install$green hestia-web-server? $re  [y/n]: " -i "n" "hestia"
read -ep "  $c2  install$green guake? $re              [y/n]: " -i "n" "guake"
read -ep "  $c2  install$green custom-grub? $re        [y/n]: " -i "n" "grub"
read -ep "  $c2  install$green sudo-color? $re         [y/n]: " -i "n" "auto"
read -ep "$purple ---------------------------------------------$re

$c2 $yellow begin installation? $re         [y/n]: " -i "y"               "continue"
  
if [ $continue == y ]; then echo -e "\n\n\t --$cyan OK$re -- \n\n"; else exit 1; fi; 
## REMEMER TO CHANGE VAR-NAMES.

##
if [ $cloudpanel == y ]; then echo "installing cloudpanel";
apt -y install curl wget sudo;
curl -sS https://installer.cloudpanel.io/ce/v2/install.sh -o install.sh; \
echo "f25e3fe3dc028ef8eda281868ab606b5b80bc6ba74a253ae54ab5fd1e61c287d install.sh" | \
sha256sum -c && sudo bash install.sh
else echo "OK"; fi

## 
if [ $hestia == y ]; then echo "installing hestia";
wget -O 12hestia https://raw.githubusercontent.com/hestiacp/hestiacp/release/install/hst-install.sh; bash 12hestia;
else echo "OK"; fi

##
if [ $guake == y ]; then echo "installing guake";
apt -y install guake;
else echo "OK"; fi

##
if [ $grub == y ]; then echo "installing grub";
wget -O 12grub.sh $rootgit/sh/grub.sh; bash 12grub.sh;
else echo "OK"; fi

##
if [ $auto == y ]; then tput blink ; echo "installing auto-sudo";
wget -O auto-sudo.sh $rootgit/sh/auto-sudo.sh; bash auto-sudo.sh; 
else echo "OK"; fi
 




echo "
  $c2 -- $green $blink https://12ants.github.io
$re $normal

  enjoy!

"
