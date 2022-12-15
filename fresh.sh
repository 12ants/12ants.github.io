
#############################################################
#### INSTALL MINIAL DESKTOP ENV #############################
####
sudo -s
apt update
apt install gpm -y                 #  bash mouse support
apt install xfce4-session-y        #  minimal desktop env
apt install xinit -y               #  minimal desktop env
apt install tint2 -y               #  minial start-menu
####
startx # to start xfce4 (might need reboot)
####
####
####

