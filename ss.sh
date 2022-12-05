#/bin/bash
#### SS by leon.osmik.se
green="tput setaf 2"; red="tput setaf 1"; def="tput sgr0"; dim="tput dim";
clear;
BLA_metro=( 1 '   o 0 ' "   0 o " '   o 0 ' '   0 o ' )
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
${def}; echo -e "   \v \v \v   ++ WELCOME TO THE INSTALLER ++ \v \v \v Updating system -- Press [Crtl+C] to abort ... \v \v \v "
BLA_loading_animation_pid="${!}"
}
BLA::stop_loading_animation() {
kill "${BLA_loading_animation_pid}" &> /dev/null
printf "\n"
tput cnorm # Restore the terminal cursor
}
trap BLA::stop_loading_animation SIGINT
echo -e " \v\v "
BLA::start_loading_animation "${BLA_metro[@]}"
sudo apt update -y &> /dev/null ; apt install -qq -y curl inxi tar unzip &> /dev/null ;
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
####
echo ${cyan};echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";echo "${c75}";
tput cuu 4;
read -p ${cyan}"  ----------${re} Disable ROOT password and add autocomplete? [Y/n]   ${left2}" yn;
tput cuf 52 cuu 1;
if [ "$yn" != "${yn#[Nn]}" ];
then 
#### DONT
echo "${re} nope ";echo;echo;echo;echo;sleep 1;
else
#### DO
## DISABLE PWD
echo "${re} OK ";sleep 2;echo ${dim} "${dim}" ${noso};echo;echo;echo;echo;
cp  /etc/sudoers.d/10-installer  /etc/sudoers.d/10-installer-backup;
echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10-installer;
## ROOT AUTOCOMPLETE
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
wget https://github.com/0smik/ss/raw/main/tard.jpg ;
####################################
#### -Write GRUB config file--######
####################################
echo '
GRUB_BACKGROUND="/boot/grub/tard.jpg"
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=false
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
####################################
#### -All done!--###################
####################################
fi





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







echo; echo;
read -p "    ${pink}--${normal}  Install or update the web-server? [Y/n] " yn;if [ "$yn" != "${yn#[Nn]}" ];then echo "    --  No - OK";else
echo -e "    ${purple}--${normal}  YES - ${green}OK${gray} - Hold on ${normal}updating..."
#### UPDATES SILENTLY ##################
apt update -qq > out.log 2>/dev/null;
########################################
sleep 0.1;echo ${darkgray}
sleep 0.1;echo
apt install -qq -y apache2 ghostscript libapache2-mod-php curl lynx mariadb-server tar ;
sleep 0.1;echo
sleep 0.1;echo ${normal}
read -p "    ${yellow}--${normal}  Install or update PHP? [Y/n] " yn;if [ "$yn" != "${yn#[Nn]}" ];then echo "    --  No - OK";else echo "    --  YES - OK";
sleep 0.1;echo
sleep 0.1;echo ${darkgray}
apt install -qq -y php php-gd php-memcache php-soap php-tidy php-cli php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip ;
sleep 0.1;echo
sleep 0.1;echo
fi
sleep 0.1;echo
fi


sleep 0.1;echo "    ${pink}--${normal} downloading-wordpress -----"
cd ${install_dir}
echo ; sleep 0.1 ;
sleep 1;echo " ${darkgray} ${darkgray}";
wget "http://wordpress.org/latest.tar.gz"&


##################################################################
###### Ask for URL (if none, generate one) #######################
##################################################################
read -p "    ${pink}--${normal} ${blue}Base url: like: -- ${normal}myaddress.net -- ${blue}(leave as is if unsure):${white} " userurl ;
if [[ -z "$userurl" ]]; then
userurl="wordpress$(date +%d%m%y)" ;
fi

read -p "    ${yellow}--${normal} ${blue}New directory: like: ${pink}--${normal} ${white}new-wp-site ${pink}--${normal} ${blue}(leave empty if unsure):${white} " userdir
install_dir="/var/www/${userurl}${userdir}"
sleep 0.1;echo
sleep 0.1;echo
read -p "    ${red}--${normal}  Change site directory? [y/N] " yn;if [ "$yn" != "${yn#[Yy]}" ];then echo "    ${pink}--${normal}  Yes - OK";
sleep 0.1;echo
sleep 0.1;echo
read -p "    ${blue}--${normal}  New directory? (default: $install_dir): " install_dir
install_dir="${install_dir}/${userurl}${userdir}"
sleep 0.1;echo
echo "    ${pink}--${normal}  OK"
sleep 0.1;echo
else
echo "    ${white}--${normal}  NO - OK";
fi

sleep 0.1;echo " ${white} "
mv -n ${install_dir} ${install_dir}_backup 2>/dev/null;
sleep 0.2;echo "    ${pink}--${normal} Creating folders... "
sleep 0.2;echo "    ${pink}--${normal} OK                  "
sleep 0.2;echo "    ${pink}--${normal} Web directory: ${install_dir}"
sleep 0.2;echo "    ${pink}--${normal} Checking apache2..."
mkdir -p -m 0775 ${install_dir} ;
sleep 0.1 ;
chown www-data: ${install_dir} -R ;
sleep 0.2;echo "    ${pink}--${normal} OK: Apache2 directory is ready!"
sleep 0.1;echo " ${purple} "
sleep 0.2;echo "    -------------------------"



echo "
<VirtualHost *:80>
ServerName ${userurl}
ServerAlias www.${userurl}
DocumentRoot ${install_dir}
<Directory ${install_dir}>
Options FollowSymLinks
AllowOverride all
DirectoryIndex index.php
Require all granted
</Directory>
<Directory ${install_dir}/wp-content>
AllowOverride all
Options FollowSymLinks
Require all granted
</Directory>
</VirtualHost>
php_value memory_limit 260M
php_value post_max_size 2222M
php_value upload_max_filesize 2222M
" > /etc/apache2/sites-available/${userurl}.conf;

echo 
a2ensite ${userurl}
a2enmod rewrite 
a2enmod headers
a2enmod ssl
a2dissite 000-default
service apache2 restart;
service mariadb restart;
echo

db_name="wp`date +%N`";
sleep 0.2;echo ;
db_user="`date +%B%N`";
sleep 0.2;echo ;
db_password=`date|md5sum|cut -c 1-14`;





echo "
    $green ###################################### ${normal}
    $darkblue db_name:$gray $db_name            
    $darkblue db_user:$gray $db_user            
    $darkblue db_password:$gray $db_password    
    $green ###################################### ${normal}
"





mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE $db_name;
CREATE USER '$db_user'@'localhost' IDENTIFIED BY '$db_password';
GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT


systemctl restart mysql;
systemctl restart mariadb;
systemctl restart apache2;
service apache2 restart;
service mariadb restart;








chown www-data: ./ -R;chmod 775 ./ -R
echo ; sleep 4 ; 
tar -xzf latest.tar.gz --overwrite --strip-components=1;
echo ; sleep 0.2 ;
chown www-data: ./ -R
chmod 775 ./ -R



chown www-data: ./ -R
echo "$green             ###################################################"
echo "$green             ####${normal} Creating WP-config and set DB credentials${green} #### "
mv ${install_dir}/wp-config-sample.php ${install_dir}/wp-config.php ; sleep 0.2 ;
sed -i "s/database_name_here/$db_name/g" ${install_dir}/wp-config.php ; sleep 0.2 ;
sed -i "s/username_here/$db_user/g" ${install_dir}/wp-config.php ; sleep 0.2 ;
sed -i "s/password_here/$db_password/g" ${install_dir}/wp-config.php ; sleep 0.2 ;
echo "$green             ###################################################${normal}"
mv -n ${install_dir}/index.html ${install_dir}/index.html_backup 2>/dev/null;

##### Set WP Salts
grep -A50 'table_prefix' $install_dir/wp-config.php > /tmp/wp-tmp-config
sed -i '/**#@/,/$p/d' $install_dir/wp-config.php
lynx --dump -width 200 https://api.wordpress.org/secret-key/1.1/salt/ >> $install_dir/wp-config.php
cat /tmp/wp-tmp-config >> $install_dir/wp-config.php && rm /tmp/wp-tmp-config -f
#############
service apache2 restart
echo     "      It's -> OK"
chown www-data: $install_dir -v
chmod 775 $install_dir -v


echo "Removing default WordPress themes..."
rm -rf wp-content/themes/twentytwenty
rm -rf wp-content/themes/twentytwentyone
rm -rf wp-content/themes/twentytwentytwo
rm -rf wp-content/themes/twentytwentythree



echo "    "
echo >> ~/.$userurl-$userdir-LOGIN.txt MYSQL --- db-name-db-user:  $db_name  ------  db-pw:  $db_password  -----

tput setaf 2
echo " --------------------------------------------------------"
echo " -- Database credentials saved in: ----------------------"
echo " -- /homedirectory/.$userurl-$userdir-LOGIN.txt (Hidden folder).--"
sleep 0.1
echo " --------------------------------------------------------"
sleep 0.1
systemctl restart apache2
echo enjoy
