#/bin/bash
###########################################################
#### START-UP-SCRIPT for Ubuntu or Debian like systems ####
###########################################################
#############################
#### SS by leon.osmik.se ####
#### www.12ants.com #########
#############################
#############################
#### Loading animation ######
#############################
green="tput setaf 2"; red="tput setaf 1"; def="tput sgr0"; dim="tput dim";
clear;
BLA_metro=( 1 '   o  0 ' "   0  o " '   o  0 ' '   o  x ' )
declare -a BLA_active_loading_animation
BLA::play_loading_animation_loop() {
while true ; do
for frame in "${BLA_active_loading_animation[@]}" ; do
${green} ; ${dim} ; tput civis ;
#printf "\r%s" "    [ ${frame} ]"
printf "\r%s ]"; printf "\r%s" "${frame}"; ${def}; printf "\r%s" "  ["; tput cuf 4 ; printf "] "; 
sleep "${BLA_loading_animation_frame_interval}"
${def}
done
done
}
BLA::start_loading_animation() {
BLA_active_loading_animation=( "${@}" )
# Extract the delay between each frame from array BLA_active_loading_animation
BLA_loading_animation_frame_interval="${BLA_active_loading_animation[0]}"
unset "BLA_active_loading_animation[0]"
tput civis # Hide the terminal cursor
BLA::play_loading_animation_loop & 2> /dev/null
clear


########
${def}; echo -e "   \v \v \v   ++ WELCOME TO THE INSTALLER ++ \v \v \v Updating system -- Press [Crtl+D] to abort ... \v \v \v "

BLA_loading_animation_pid="${!}"
}
BLA::stop_loading_animation() {
kill "${BLA_loading_animation_pid}" &> /dev/null
printf "\n"
tput cnorm # Restore the terminal cursor
}
trap BLA::stop_loading_animation SIGINT
echo -e " \v\v\t\t "
BLA::start_loading_animation "${BLA_metro[@]}"
sudo apt update -y &> /dev/null ; apt install -qq -y curl gpm inxi tar unzip &> /dev/null ;
tput cub 4 ; ${green}; echo "OK"
${green}; echo -e "\v\t\v done! \v\v"
BLA::stop_loading_animation&> /dev/null
sleep 1;


export bold=$(tput bold) dim=$(tput dim) so=$(tput smso) noso=$(tput rmso) rev=$(tput rev) re=$(tput sgr0) normal=$(tput sgr0) \
redb=$(tput setab 1) greenb=$(tput setab 2) yellowb=$(tput setab 3) blueb=$(tput setab 4) purpleb=$(tput setab 5) cyanb=$(tput setab 6) grayb=$(tput setab 7) \
red=$(tput setaf 1)  green=$(tput setaf 2)  yellow=$(tput setaf 3)  blue=$(tput setaf 4)  purple=$(tput setaf 5)  cyan=$(tput setaf 6)  gray=$(tput setaf 7) \
white=$(tput setaf 7 bold)  pink=$(tput setaf 5 bold) darkblue=$(tput setab 5 bold) \
left2=$(tput cub 2) up1=$(tput cuu1) c75="  ---------------------------------------------------------------------------"



###################################
####-UBUNTU-AUTOINSTALLER-#########
###################################
####
clear
echo;echo ${re};
echo ${blue}${dim}"    ***********************************************************************" ${re}${bold}
echo ${cyan}${dim}"    ******${re}${bold} Install some useful commands and tweaks for ubuntu / bash ${cyan}${dim}******" ${re}
echo ${blue}${dim}"    ***********************************************************************"
echo ${re}


###################################
#### DISABLE ROOT PASSWORD ########
#### ADD AUTOCOMPLETE #############
#### COLOR-ALIAS ##################
###################################
###################################
echo ${cyan};echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";
tput cuu 4;
read -p ${cyan}"  ----------${re} Disable ROOT password and add autocomplete? [Y/n]  ${left2}" yn;
tput cuf 52 cuu 1;
if [ "$yn" != "${yn#[Nn]}" ]; then
echo "${re} nope ";echo -e \v\v\v\v;
else ###### ---- [YES] ----- ######
########### DISABLE PWD ###########
echo "${re} OK ";sleep 2;echo ${dim} "${dim}" ${noso}; echo -e "\v\v\v\v";
cp  /etc/sudoers.d/10-installer  /etc/sudoers.d/10-installer-backup;
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
let prompt_x=$(tput cols)-40
#  Move up one; not sure why we need to do this, but without this, I always
tput sc; tput cup 0 ${prompt_x}; tput setaf 4;
echo -e "                                ";
tput cup 1 ${prompt_x}; echo -e "${netip}/ ${pubip}"; tput rc
}
PROMPT_COMMAND=prompt_command
###############################################

" >> ~/.bash_aliases;
echo "${re}${green}${bold}     DONE ${re}";echo;echo;echo;echo;sleep 1;
fi
#### DONE #########################
###################################
clear;


####################################
#### INSTALL CUSTOM GRUB ###########
####################################
####
echo ${cyan};echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";
tput cuu 4;
read -p ${cyan}"  ----------${re} Install tard-grub? [Y/n]   ${left2}" yn;
tput cuf 52 cuu 1;
if [ "$yn" != "${yn#[Nn]}" ];
then 
#### DONT
echo "${re} nope ";echo;echo;echo;echo;sleep 1;
else
#### DO
#### -Create folder--###############
####################################
mkdir -p -m 775 /boot/grub/ ; 
cd /boot/grub/ ;
####################################
#### -Download Picture--############
####################################
wget https://github.com/12ants/ss/raw/main/tard.jpg ;
####################################
#### -Write GRUB config file--######
####################################
echo '
GRUB_BACKGROUND="/boot/grub/tard.jpg"
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
GRUB_TIMEOUT_STYLE=menu
GRUB_TIMEOUT=12
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_DISABLE_OS_PROBER=false
GRUB_GFXMODE="1024x768"
GRUB_HIDDEN_TIMEOUT=0
' > /etc/default/grub; 
sleep 0.4; 
update-grub ; 
sleep 0.4; echo -e "\v\t -- GRUB INSTALLED SUCCESSFULLY \v" sleep 0.4; 
fi
####################################
#### -All done!--###################
####################################





###################################
#### WEBMIN--Install ##############
###################################
####
echo ${cyan};echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";
tput cuu 4;
read -p ${cyan}"  ----------${re} Install WEBMIN? [Y/n]   ${left2}" yn;
tput cuf 52 cuu 1;
if [ "$yn" != "${yn#[Nn]}" ];
then 
#### DONT
echo "${re} nope ";echo;echo;echo;echo;sleep 2;
else
#### DO
echo "${re} OK ";sleep 2;echo ${dim};echo;echo;echo;echo;
apt install -qq -y perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl tar;
mkdir -p /home/dl/webmin;
cd /home/dl/webmin;
echo "${re}" ${purple};
wget https://download.webmin.com/devel/tarballs/webmin-current.tar.gz; echo "${blue}"
tar -xf webmin-current.tar.gz --strip-components=1; 
fi
echo;echo ${up1}${up1};
####
#### WEBMIN-setup -- prompt
read -p ${cyan}"  ----------${re}  Run ${cyan}WEBMIN${re} Setup? [Y/n]   ${left2}" yn;
if [ "$yn" != "${yn#[Nn]}" ];
then 
echo "${re} nope ";echo;echo;echo;echo;sleep 2;
else
#### DO
echo "${re} OK -- recommended cloudflare-port: 2087";sleep 2;

./setup.sh /usr/local/webmin;
##### ALSO SAY DONE
echo;echo;echo;echo;
echo "${re}${green}${bold}     DONE ${re}";echo;echo;echo;echo;sleep 2;
fi
#### DONE #########################
###################################





###################################
#### WP--Install ##################
###################################
####
echo ${cyan};echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";
tput cuu 4;
read -p ${cyan}"  ----------${re} Install Wordpress? [Y/n]   ${left2}" yn;
tput cuf 52 cuu 1;
if [ "$yn" != "${yn#[Nn]}" ];
then 
#### DONT
echo "${re} nope ";echo;echo;echo;echo;sleep 2;
else
#### DO
mkdir -p /home/temp/
cd /home/temp
wget -O wp 12ants.github.io/wp.sh && bash wp
fi



###################################
#### Cloud-Panel--Install ##############
###################################
####
echo ${cyan};echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";
tput cuu 4;
read -p ${cyan}"  ----------${re} Install Cloud-Panel? [Y/n]   ${left2}" yn;
tput cuf 52 cuu 1;
if [ "$yn" != "${yn#[Nn]}" ];
then 
#### DONT
echo "${re} nope ";echo;echo;echo;echo;sleep 2;
else
#### DO
mkdir -p /home/temp/
cd /home/temp
wget -O cp.sh https://installer.cloudpanel.io/ce/v2/install.sh && bash cp.sh
fi



###################################
#### Desktop--Install #############
###################################
####
echo ${cyan};echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";
tput cuu 4;
read -p ${cyan}"  ----------${re} Install Xfce4-Desktop-Enviroment? [Y/n]   ${left2}" yn;
tput cuf 52 cuu 1;
if [ "$yn" != "${yn#[Nn]}" ];
then 
#### DONT
echo "${re} nope ";echo;echo;echo;echo;sleep 2;
else
#### DO
apt install -y -qq xfce4-session xfce4-goodies xfce4-panel synaptic xinit luakit     #  minimal desktop env
echo -e "\v\t Type [ startx ] to execute \v\v"
fi

echo -n -e "\v\v\v\v\t\t have fun! -- Your IP:  "
hostname -I; echo ; echo ; echo ; echo ;
