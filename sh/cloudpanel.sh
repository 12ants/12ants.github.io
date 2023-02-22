wget -O cloudpanel.sh https://installer.cloudpanel.io/ce/v2/install.sh; bash cloudpanel.sh;

read -ep "  --  Restart?" -i "y" restart
if [ $restart == y ] then reboot; else echo OK; fi 
