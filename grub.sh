

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
rm /etc/default/grub.d/*;

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


