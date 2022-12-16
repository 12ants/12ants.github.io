
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
wget https://github.com/0smik/ss/raw/main/tard.jpg ;
wget https://github.com/0smik/ss/raw/main/tard4.jpg ;
####################################
#### -Write GRUB config file--######
####################################
echo '
GRUB_BACKGROUND="/boot/grub/tard4.jpg"
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
GRUB_TIMEOUT_STYLE=menu
GRUB_TIMEOUT=12
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_DISABLE_OS_PROBER=false
GRUB_GFXMODE="800x600"
GRUB_HIDDEN_TIMEOUT=0
' > /etc/default/grub ; 
sleep 0.4 ; 
update-grub ; 
echo "GRUB INSTALLED SUCCESSFULLY"
fi
####################################
#### -All done!--###################
####################################

