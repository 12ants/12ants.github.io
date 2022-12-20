#/bin/sh
clear;echo;echo
if [ "$(id -u)" != "0" ]; then  
echo;echo;echo "  This script must be run as root..." 1>&2  ;echo;echo
exit 1
fi  

sleep 0.1
########-set-colors-######################################################
#normal=$(tput sgr0);
normal=$'\e[0m';bold=$(tput bold);red="$bold$(tput setaf 1)";green=$(tput setaf 2);fawn=$(tput setaf 3); beige="$fawn";yellow="$bold$fawn";darkblue=$(tput setaf 4);blue="$bold$darkblue";purple=$(tput setaf 5); magenta="$purple"  ; 
pink="$bold$purple";darkcyan=$(tput setaf 6);cyan="$bold$darkcyan";gray=$(tput setaf 7);darkgray="$bold"$(tput setaf 0);white="$bold$gray";blink=$(tput blink);
##    ${normal}
##    ${bold}
##    ${red}
##    ${green}
##    ${fawn}
##    ${yellow}
##    ${darkblue}
##    ${blue}
##    ${purple}
##    ${pink}
##    ${cyan}
##    ${gray}
##    ${darkgray}
##    ${white}
sleep 0.1
echo ""
sleep 0.1;tput setaf 6 ;echo "         ------------------------------------------------------"
sleep 0.1;tput setaf 5 ;echo "        ------------------------------------------------------"
sleep 0.1;tput setaf 7 ;echo "      - Welcome to the autolamp-wordpress-installer - - - --"
sleep 0.1;tput setaf 3 ;echo "     - - - - - - - - - - - - - - - - - - - - - - - - - - -"
sleep 0.1;tput setaf 2 ;echo "   -----------------------------------------------------"
sleep 0.1;tput setaf 1 ;echo "  -- - - - - - - - - - - - - - - - - - - - - - - - - -"
sleep 0.1;tput setaf 6 ;echo "                             "    
sleep 0.1;tput setaf 4 ;echo "                           #  "    
sleep 0.1;tput setaf 6 ;echo "                           #  "    
sleep 0.1;tput setaf 5 ;echo "                           #  "    
sleep 0.1;tput setaf 6 ;echo "                           #  "    
sleep 0.1;tput setaf 2 ;echo "                           #  "    
sleep 0.1;tput setaf 6 ;echo "                           #  "    
sleep 0.1;tput setaf 7 ;echo "                           #  "    
echo ""
sleep 0.1;echo ${normal}
sleep 0.1;echo ${normal}
read -p "    ${pink}--${normal}  Install or update the web-server? [Y/n] " yn;if [ "$yn" != "${yn#[Nn]}" ];then echo "    --  No - OK";else
echo -e "    ${purple}--${normal}  YES - ${green}OK${gray} - Hold on ${normal}${blink}updating..."
#### UPDATES SILENTLY ##################
apt update -qq > out.log 2>/dev/null;
########################################


##################################################################
###### Ask for URL (if none, generate one) #######################
##################################################################
read -p "    ${pink}--${normal} ${blue}Base url: like: -- ${normal}myaddress.net -- ${blue}(leave as is if unsure):${white} " userurl ;
if [[ -z "$userurl" ]]; then
userurl="wordpress$(date +%d%m%y%S)" ;
fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

sleep 0.1;echo
sleep 0.1;echo "    ${cyan}--${normal} OK ${pink}--${normal} $userurl "
sleep 0.1;echo
sleep 0.1;echo
# read -p "    ${yellow}--${normal} ${blue}New directory: like: ${pink}--${normal} ${white}new-wp-site ${pink}--${normal} ${blue}(leave empty if unsure):${white} " userdir
sleep 0.1;echo
sleep 0.1;echo
sleep 0.1;echo "    ${darkcyan}--${normal} OK ${pink}--${normal}"

sleep 0.1;echo
sleep 0.1;echo
sleep 0.1;echo
sleep 0.1;echo
install_dir="/var/www/${userurl}"
sleep 0.1;echo
sleep 0.1;echo
read -p "    ${red}--${normal}  Change site directory? [y/N] " yn;if [ "$yn" != "${yn#[Yy]}" ];then echo "    ${pink}--${normal}  Yes - OK";
sleep 0.1;echo
sleep 0.1;echo
read -ep gggg -i "${?}" llll

read -ep "    ${blue}--${normal}  Change directory: --> " -i "${install_dir}" install_dir
install_dir="${install_dir}/${userurl}"
sleep 0.1;echo
echo "    ${pink}--${normal}  OK"
sleep 0.1;echo
else
echo "    ${white}--${normal}  NO - OK";
fi
sleep 0.1;echo

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

sleep 0.1;echo " ${purple} "
sleep 0.1;echo "    -------------------------"
sleep 0.1;echo " ${white} "
mv -n ${install_dir} ${install_dir}_backup 2>/dev/null;
sleep 0.2;echo "    ${pink}--${normal} Creating folders... "
sleep 0.2;echo "    ${pink}--${normal} OK                  "
sleep 0.2;echo "    ${pink}--${normal} Web directory: ${install_dir}"
sleep 0.2;echo "    ${pink}--${normal} Checking apache2..."
mkdir -p -m 0775 ${install_dir} ;
sleep 0.1 ;
#### DOWNLOAD WP-FILES
chown www-data: ${install_dir} -R ;
cd ${install_dir};
wget -nc "http://wordpress.org/latest.tar.gz" & 2> /dev/null
cd ${install_dir}/wp-content/plugins
wget -nc https://downloads.wordpress.org/plugin/simple-history.zip & 2> /dev/null
wget -nc https://downloads.wordpress.org/plugin/filester.zip & 2> /dev/null
wget -nc https://downloads.wordpress.org/plugin/webp-express.zip & 2> /dev/null
wget -nc https://downloads.wordpress.org/plugin/really-simple-ssl.zip & 2> /dev/null
cd ${install_dir}/wp-content/themes
wget -nc -O blank1.zip https://github.com/0smik/blank1/archive/refs/heads/main.zip & 2> /dev/null


sleep 0.2;echo "    ${pink}--${normal} OK: Apache2 directory is ready!"
sleep 0.1;echo " ${purple} "
sleep 0.2;echo "    -------------------------"
sleep 0.1;echo
sleep 0.1;echo " ${white} "
sleep 0.1;echo

##################################################################


sleep 0.1;echo ${darkgray}
sleep 0.1;echo
apt install -qq -y apache2 ghostscript libapache2-mod-php curl lynx mariadb-server mariadb-client toilet tar unzip ;
sleep 0.1;echo
sleep 0.1;echo ${normal}
sleep 0.1;echo
sleep 0.1;echo ${darkgray}
apt install -qq -y php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip ;
sleep 0.1;echo
sleep 0.1;echo
sleep 0.1;echo
sleep 0.1;echo
echo "                  ${bold}${green} ✓ ${normal}great success!"
sleep 0.1;echo
sleep 0.1;echo
fi
sleep 0.1;echo ${gray}
echo "    -- OK - Moving on... ";


sleep 0.1;echo
sleep 0.1;echo













sleep 0.1;echo "                  "
sleep 0.1;echo "$darkgray  ########################################################################## "
sleep 0.1;echo "$darkgray  ####################-${bold}${normal}apache-site-config${darkgray}-################################ "
sleep 0.1;echo "$darkgray  ########################################################################## "
sleep 0.1;



############################
#### SSL - Self-Signed #####
############################
##########
##########
read -ep "SSL-self-signed Install directory: " -i $(echo $install_dir)/ssl ssl_dir
mkdir -p ${ssl_dir}
cd ${ssl_dir}
openssl genrsa -out server.key 2048
openssl rsa -in server.key -out server.key
openssl req -sha256 -new -key server.key -out server.csr -subj '/CN=localhost'
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
cat server.crt server.key > cert.pem
##########
##########
#### CREATE APACHE VIRTUAL-HOST ####
sleep 0.1; echo ' 
<IfModule mod_ssl.c>
<VirtualHost _default_:443>
DocumentRoot ${install_dir}
ServerName ${userurl}
ServerAlias ${userurl}
ServerAdmin webmaster@${userurl}
SSLEngine on
SSLCertificateFile ${ssl_dir}/cert.pem
SSLCertificateChainFile ${ssl_dir}/server.crt
SSLCACertificatePath ${ssl_dir}/
<FilesMatch "\.(cgi|shtml|phtml|php)$">
SSLOptions +StdEnvVars
</FilesMatch>
<Directory /usr/lib/cgi-bin>
SSLOptions +StdEnvVars
</Directory>
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
' > /etc/apache2/sites-available/${userurl}.conf ;

########
########

 echo
 "            
    
                        ${pink}--${normal}  ${bold}${green}  All good... ✓

"
sleep 0.2;echo "$magenta  ##########################################################################"
sleep 0.2;echo "$magenta  #################-${normal}enable-site${magenta}-############################################"
sleep 0.2;echo "$magenta  ##########################################################################"
sleep 0.2;echo ${normal}
sleep 0.2;echo 
rm /etc/apache2/sites-enabled/*
a2ensite ${userurl}
a2enmod rewrite 
a2enmod headers
a2enmod ssl
a2dissite 000-default
systemctl restart apache2;
service apache2 restart;
service mariadb restart;
echo
sleep ;echo 
sleep 0.2;echo "$yellow  ##########################################################################"
sleep 0.2;echo "$yellow  ###########${normal}-Generating-MySql-credentials-${yellow}#################################"
sleep 0.2;echo "$yellow  ##########################################################################"

sleep 0.2;echo;
sleep 0.2;echo;
sleep 0.2;echo -e "${blue}         ####${normal}\033[5m RaNdoMiZing\033[0m ${pink}####"
db_name="wp`date +%N`";
sleep 0.2;echo ;
db_user="`date +%B%N`";
sleep 0.2;echo ;
db_password=`date|md5sum|cut -c 1-14`;
sleep 0.2;echo ; echo "        $bold $purple done  ✓ $normal"
sleep 0.2;echo ;
sleep 0.1;echo ;
sleep 0.1;echo ;
sleep 0.1;echo ;
sleep 0.2;echo "       ${pink}--${normal} $blue your credentials $normal"
sleep 0.2;echo "
    $green ###################################### ${normal}
    $darkblue db_name:$gray $db_name            
    $darkblue db_user:$gray $db_user            
    $darkblue db_password:$gray $db_password    
    $green ###################################### ${normal}


"
sleep 0.41;echo "";  echo "                  OK ✓"
sleep 0.41;echo " ";
sleep 0.41;echo "     $green ################################################################# ${normal}";
sleep 0.41;echo     "        ${pink}--${normal} Injecting in MariaDB... (codes that is....)"
sleep 0.41;echo "     $green ################################################################# ${normal}";

mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE $db_name;
CREATE USER '$db_user'@'localhost' IDENTIFIED BY '$db_password';
GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo ; sleep 0.1 ;
echo ; sleep 0.1 ;
sleep 0.1;echo "    ${pink}--${normal} mysql - Success  ✓"
systemctl restart mysql;
systemctl restart mariadb;
systemctl restart apache2;
sleep 0.1;echo ; sleep 0.1 ;echo ; sleep 0.1 ;

echo ; sleep 0.2 ;
echo "             ${pink}--${normal} automating -----"
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;
sleep 1;echo "     $green OK ${normal}";
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;

sleep 0.1;echo "    ${pink}--${normal} downloading-wordpress -----"
cd ${install_dir}
echo ; sleep 0.1 ;
sleep 1;echo " ${darkgray} ${darkgray}";
wget -nc "http://wordpress.org/latest.tar.gz";
echo ; sleep 0.1 ;
echo ; sleep 0.1 ; echo " $green      ${pink}--${normal} packet secured ✓ $normal "
echo ; sleep 0.1 ;
chown www-data: ./ -R;chmod 775 ./ -R
echo ; sleep 0.1 ; 
tar -xzf latest.tar.gz --overwrite --strip-components=1;
echo ; sleep 0.2 ;
chown www-data: ./ -R
chmod 775 ./ -R
sleep 0.1;echo " $fawn    ----------- unzipping -----------"
echo ; sleep 0.1 ;
echo ; sleep 0.1 ; echo " $green    the chicken is out of the box  ✓ $normal "
sleep 0.1;echo "     $green  ${normal}";
echo ; sleep 0.1 ;
toilet -t --gay "almost there!"
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;
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
echo "
@ini_set( 'upload_max_filesize' , '128M' );
@ini_set( 'post_max_size', '132M');
@ini_set( 'memory_limit', '256M' );
@ini_set( 'max_execution_time', '300' );
@ini_set( 'max_input_time', '300' );
" >> $install_dir/wp-config.php
echo "Removing default WordPress themes..."
rm -rf wp-content/themes/twentytwentytwo
rm -rf wp-content/themes/twentytwentythree

echo "Removing default WordPress plugins..."
cd ${install_dir}/wp-content/plugins
rm -rf akismet
rm -rf hello.php
echo "Fetching simple-history plugin...";
wget -nc https://downloads.wordpress.org/plugin/simple-history.zip;
unzip -q simple-history.zip;
wget -nc https://downloads.wordpress.org/plugin/filester.zip;
unzip -q filester.zip
wget -nc https://downloads.wordpress.org/plugin/webp-express.zip;
unzip -q webp-express.zip
wget -nc https://downloads.wordpress.org/plugin/really-simple-ssl.zip;
unzip -q really-simple-ssl.zip
cd ${install_dir}/wp-content/themes
wget -nc -O blank1.zip https://github.com/0smik/blank1/archive/refs/heads/main.zip
unzip -q blank1.zip
mv blank1-main blank1

echo "Defining the default theme...";
echo "
define( 'WP_DEFAULT_THEME', 'blank1' );" >> ${install_dir}/wp-config.php

service apache2 restart
chown www-data: $install_dir
chmod 775 $install_dir







echo "    "
echo >> /home/.$userurl-$userdir-LOGIN.txt MYSQL --- db-name-db-user:  $db_name  ------  db-pw:  $db_password  -----

tput setaf 2
echo " --------------------------------------------------------"
echo " -- Database credentials saved in: ----------------------"
echo " -- /home/.$userurl-$userdir-LOGIN.txt (Hidden folder).--"
sleep 0.1
echo " --------------------------------------------------------"
sleep 0.1





sleep 0.1;
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;

sleep 0.1;echo ; sleep 0.1 ;
sleep 0.1;echo "    ${pink}--${normal} OK"
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;
echo ; sleep 0.6 ;
toilet -t --gay "
 all done!
"
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;
chown www-data: ${install_dir} -R
echo ${bold};
echo ; sleep 0.1 ;
echo ; sleep 0.1 ;

sleep 0.1 ;echo;sleep 0.1 ;echo;sleep 0.1 ;echo;sleep 0.1 ;
sleep 0.1 ;echo;sleep 0.1 ;echo;sleep 0.1 ;echo;sleep 0.1 ;
sleep 0.1;tput setaf 6 ;echo "";
sleep 0.1;tput setaf 6 ;echo "";
sleep 0.1;tput setaf 1 ;echo "                         / / / / / / / / /  brought to you by... / / / / / / / / /";
sleep 0.1;tput setaf 6 ;echo "                      ___________________________________________________________";
sleep 0.1;tput setaf 5 ;echo "                     ___________________________________________________________";
sleep 0.1;tput setaf 6 ;echo "                                                                                ";
sleep 0.1;tput setaf 5 ;echo "                     ::::::::   ::::::::    :::   :::   ::::::::::: :::    ::: ";
sleep 0.1;tput setaf 5 ;echo "                   :+:    :+: :+:    :+:  :+:+: :+:+:      :+:     :+:   :+:   ";
sleep 0.1;tput setaf 5 ;echo "                  +:+    +:+ +:+        +:+ +:+:+ +:+     +:+     +:+  +:+     ";
sleep 0.1;tput setaf 5 ;echo "                 +#+    +:+ +#++:++#++ +#+  +:+  +#+     +#+     +#++:++       ";
sleep 0.1;tput setaf 5 ;echo "                +#+    +#+        +#+ +#+       +#+     +#+     +#+  +#+       ";
sleep 0.1;tput setaf 5 ;echo "               #+#    #+# #+#    #+# #+#       #+#     #+#     #+#   #+#       ";
sleep 0.1;tput setaf 5 ;echo "               ########   ########  ###       ### ########### ###    ###       ";
sleep 0.1;tput setaf 5 ;echo "           ___________________________________________________________        ";
sleep 0.1;tput setaf 6 ;echo "          ___________________________________________________________         ";
sleep 0.1;tput setaf 7 ;echo "                                                                              ";    
sleep 0.1;tput setaf 7 ;echo "         / / / / / / / / / / / www.osmik.se / / / / / / / / / / / /   ";
sleep 0.1;tput setaf 6 ;echo "       ___________________________________________________________      ";
sleep 0.1;tput setaf 2 ;echo "      ___________________________________________________________      ";

tput setaf 3;
sleep 0.1 ;echo;
sleep 0.1 ;echo;
systemctl restart apache2
echo "    ----------------------------------------------------------   "
tput setaf 7 ; echo "              - - -> http://$userurl$userdir <- - -       "
echo -n "         - - - > NETWORK-IP: http://"; hostname -I
echo -n "    - - - > PUBLIC-IP; http://"; dig +short myip.opendns.com @resolver1.opendns.com
tput setaf 3;
echo "  ----------------------------------------------------------   "
echo "           ";    
echo;sleep 0.1 ;echo;
sleep 0.1;echo;sleep 0.1 ;echo;sleep 0.1 ;tput setaf 7 ;echo "           ...enjoy!";
sleep 0.1 ;echo;sleep 0.1 ;echo;sleep 0.1 ;echo "${pink}--${normal} OK";
systemctl restart apache2

