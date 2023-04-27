#/bin/bash
echo "--  Installing Tard-Grub 2.0..."

mkdir -p -m 775 /boot/grub/ ; 
cd /boot/grub/ ;
wget https://github.com/12ants/ss/raw/main/tard.jpg ;
rm /etc/default/grub.d/*;
echo '
GRUB_BACKGROUND="/boot/grub/tard.jpg"
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
GRUB_TIMEOUT_STYLE=menu
GRUB_TIMEOUT=2
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_DISABLE_OS_PROBER=false
GRUB_HIDDEN_TIMEOUT=0
GRUB_CMDLINE_LINUX="splash" 
GRUB_CMDLINE_LINUX_DEFAULT="splash" 

' > /etc/default/grub; 

update-grub ; 
echo -e "\v\t -- GRUB INSTALLED SUCCESSFULLY \v"
echo "  ####################################
  #### -All done!--###################
  ####################################



"
