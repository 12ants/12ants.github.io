
#############################################################
#### INSTALL MINIAL DESKTOP ENV #############################
####
apt update
apt install gpm -y                 #  bash mouse support
apt install -y -qq xfce4-session xfce4-goodies xfce4-panel synaptic xinit luakit     #  minimal desktop env
# snap install firefox
####
startx # to start xfce4 (might need reboot)
####
####
####

