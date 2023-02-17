#/bin/bash
## Install-script for Ubuntu/Debian systems
## visit https://12ants.github.io for credits
rootgit=12ants.github.io;
if [ $UID != 0 ]; then echo -e " \n\n\t This script must be run as root... try command: [ sudo -s ] \n\n " 1>&2; exit 1; fi; ## ROOT-CHECK
mkdir -p /home/00/; chmod 775 /home/00 cp /home/00/; clear; echo ; echo ; 
read -ep "  --  Root repo for install-files: [Press Enter to continue] " -i "${rootgit}" rootgit;
read -ep "  --  update system? [y/n]: " -i "n" "upsys";
if [ $upsys == y ]; then echo "updating..."; apt update; apt -y upgrade; clear; echo ""; echo ""; else echo ok ; fi; 
## ADDING COLOR-CODES -- (Need to run inside other command.)
export bold=$(tput bold) dim=$(tput dim) so=$(tput smso) noso=$(tput rmso) rev=$(tput rev) re=$(tput sgr0) normal=$(tput sgr0) \
redb=$(tput setab 1) greenb=$(tput setab 2) yellowb=$(tput setab 3) blueb=$(tput setab 4) purpleb=$(tput setab 5) cyanb=$(tput setab 6) \
grayb=$(tput setab 7) red=$(tput setaf 1) green=$(tput setaf 2) yellow=$(tput setaf 3) blue=$(tput setaf 4) purple=$(tput setaf 5) \
cyan=$(tput setaf 6) gray=$(tput setaf 7) white=$(tput setaf 7 bold) pink=$(tput setaf 5 bold) darkblue=$(tput setab 5 bold) \
left2=$(tput cub 2) up1=$(tput cuu1) c75="  ---------------------------------------------------------------------------"; clear; echo ; c2="$cyan --$re";

##############################
######## INSTALLER ############
######################
echo -e "\n\n\t --$pink Software installation$re -- \n\n"
read -ep "  $c2  install$green cloudpanel? $re         [y/n]: " -i "n"             "cloudpanel"
read -ep "  $c2  install$green hestia-web-server? $re  [y/n]: " -i "n"      "hestia"
read -ep "  $c2  install$green guake? $re              [y/n]: " -i "n"                  "guake"
read -ep "  $c2  install$green custom-grub? $re        [y/n]: " -i "n"            "grub"
read -ep "$purple ---------------------------------------------$re
  $c2 $yellow begin installation? $re         [y/n]: " -i "n"               "continue"
if [ $continue == y ]; then echo -e "\n\n\t --$cyan OK$re -- \n\n"; else exit 1; fi; 
##
## REMEMER TO CHANGE VAR-NAMES.

## 
if [ $cloudpanel == y ]; then echo "installing cloudpanel";
apt update && apt -y upgrade && apt -y install curl wget sudo
curl -sS https://installer.cloudpanel.io/ce/v2/install.sh -o install.sh; \
echo "f25e3fe3dc028ef8eda281868ab606b5b80bc6ba74a253ae54ab5fd1e61c287d install.sh" | \
sha256sum -c && sudo bash install.sh
else echo "no"; fi
## 
if [ $hestia == y ]; then echo "installing hestia";
wget -O 12hestia https://raw.githubusercontent.com/hestiacp/hestiacp/release/install/hst-install.sh; bash 12hestia;
else echo "no"; fi;
##
if [ $guake == y ]; then echo "installing guake";
apt -y install guake;
else echo "no"; fi;
##
if [ $grub == y ]; then echo "installing grub";
wget -O 12grub $rootgit/grub.sh; bash 12grub;
else echo "no"; fi;


###################################
#### DISABLE ROOT PASSWORD ########
#### ADD AUTOCOMPLETE #############
#### COLOR-ALIAS ##################
###################################
###################################

if [ "$auto" == "y" ]; then
###### ---- [YES] ----- ######
########### DISABLE PWD ###########
echo "${re} OK ";sleep 2;echo ${dim} "${dim}" ${noso}; echo -e "\v\v\v\v";
echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10-installer;
############ ROOT AUTOCOMPLETE
echo "
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then 
    . /etc/bash_completion
fi
" >> /root/.bashrc;
## COLOR-ALIAS
echo "PS1='\[\e[34m\]\u\[\e[36m\]@\[\e[2m\]\h\[\e[34m\]\[\e[96m\]\w:\[\e[m\]'
###############################################
#### DISPLAY IP - NET & PUB (TO THE RIGHT) ####
## NETWORK-IP
netip="$(hostname -I)"
## PUBLIC-IP
pubip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
function prompt_command {
#  prompt_x is where to position the cursor to write the clock
let prompt_x=$(tput cols)-20
#  Move up one; not sure why we need to do this, but without this, I always
tput sc; tput cup 0 ${prompt_x}; tput setaf 4;
echo -e "                                ";
tput cup 1 ${prompt_x}; echo -e "${netip} / ${pubip}"; tput rc
}
PROMPT_COMMAND=prompt_command
###############################################

" >> ~/.bash_aliases;
echo "${re}${green}${bold}     DONE ${re}";echo;echo;echo;echo;
else echo no
fi
fi 








echo "$green $blink
  --  https://12ants.github.io
$re $normal

  enjoy!

"
