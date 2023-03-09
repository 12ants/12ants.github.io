#!/bin/bash -x

VERBOSE=0
OS_NAME=
OS_VERSION=
OS_CODE_NAME=
ARCH=
export IP=
export DEBIAN_FRONTEND=noninteractive
[[ -z "$CREATE_AMI" ]] && export CREATE_AMI
[[ -z "$DB_ENGINE" ]] && export DB_ENGINE="MYSQL_8.0"

export IS_LXC=0
if grep -q container=lxc "/proc/1/environ"; then
  export IS_LXC=1
fi

RED_TEXT_COLOR=`tput setaf 1`
GREEN_TEXT_COLOR=`tput setaf 2`
YELLOW_TEXT_COLOR=`tput setaf 3`
RESET_TEXT_COLOR=`tput sgr0`

#####

  ARCH=`uname -m`
  OPERATING_SYSTEM=`uname -s`
  
clear; read -ep "

    --  Choose OS [u]buntu / [d]ebian " "osos";
if [ "$osos" == "u" ]
then 
        OS_NAME=Ubuntu
        OS_CODE_NAME=jammy
        OS_VERSION=22.04
      else
        OS_NAME=Debian
        OS_CODE_NAME=bullseye
        DEBIAN_VERSION=11
        OS_VERSION=11
      fi
   
  echo "Architecture: $ARCH"
  echo "OS Name: $OS_NAME"
  echo "OS Version: $OS_VERSION"
#####
  
  
if [ -z "${SWAP}" ]; then
  SWAP=true
fi

die()
{
  /bin/echo -e "ERROR: $*" >&2
  exit 1
}

verbose()
{
  if [ "$VERBOSE" -eq "1" ]; then
    echo "$@" >&2
  fi
}

setOSInfo()
{
  

  verbose "Architecture: $ARCH"
  verbose "OS Name: $OS_NAME"
  verbose "OS Version: $OS_VERSION"
}

checkRequirements()
{
  apt update
  apt -y install lsof
  checkOperatingSystem
  checkPortConflicts
  checkDatabaseEngine
  checkIfHostnameResolves
  checkRootPartitionSize
}

checkOperatingSystem()
{
  if [ "$OS_NAME" = "Debian" ] || [ "$OS_NAME" = "Ubuntu" ]; then
echo $OS_NAME
fi

}

checkPortConflicts()
{
  local OPEN_PORTS=$(lsof -i:80 -i:443 -P -n -sTCP:LISTEN)
  if [ -n "${OPEN_PORTS}" ]; then
    die "Your system already has services running on port 80 or 443"
  fi
}

checkDatabaseEngine()
{
  if [ "$OS_NAME" = "Debian" ]; then
      case $DB_ENGINE in
        "MYSQL_5.7" | "MYSQL_8.0" | "MARIADB_10.7" | "MARIADB_10.8" | "MARIADB_10.9")
          echo "Database Engine: $DB_ENGINE"
        ;;
        *)
          die "Database Engine $DB_ENGINE not supported."
        ;;
      esac
    else
      # Ubuntu 22.04
      case $DB_ENGINE in
        "MYSQL_8.0" | "MARIADB_10.6" | "MARIADB_10.8" | "MARIADB_10.9")
          echo "Database Engine: $DB_ENGINE"
        ;;
        *)
          die "Database Engine $DB_ENGINE not supported."
        ;;
      esac
    fi
}

checkIfHostnameResolves()
{
  local LOCAL_IP=$(getent hosts "$HOSTNAME" | awk '{print $1}')
  if [ -z "${LOCAL_IP}" ]; then
    die "Hostname $HOSTNAME does not resolve. Set a hosts entry in: /etc/hosts"
  fi
}

checkRootPartitionSize()
{
  # In KB
  local ROOT_PARTITION=$(df --output=avail / | sed '1d')
  if [ $ROOT_PARTITION -lt 7000000 ]; then
    die "At least 7GB of free hard disk space is required"
  fi
}

removeUnnecessaryPackages()
{
  apt -y --purge remove mysql* &> /dev/null
}

setIp()
{
  IP=$(curl -sk --connect-timeout 10 --retry 3 --retry-delay 0 https://d3qnd54q8gb3je.cloudfront.net/)
  IP=$(echo "$IP" | cut -d"," -f1)
}

setupRequiredPackages()
{
  apt -y upgrade
  apt -y install gnupg apt-transport-https debsums chrony
  DEBIAN_FRONTEND=noninteractive apt-get install -y postfix
  if [ "$SWAP" != false ] ; then
    echo "CONF_SWAPFILE=/home/.swap" > /etc/dphys-swapfile
    echo "CONF_SWAPSIZE=2048" >> /etc/dphys-swapfile
    echo "CONF_MAXSWAP=2048" >> /etc/dphys-swapfile
    DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew install dphys-swapfile
  fi
}

generateLocales()
{
  apt -y install locales locales-all 
  /usr/sbin/locale-gen en_US && /usr/sbin/locale-gen en_US.UTF-8
}

addAptSourceList()
{
  curl -fsSL https://d17k9fuiwb52nc.cloudfront.net/key.gpg | sudo gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/cloudpanel-keyring.gpg
  curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/yarn-keyring.gpg

  if [ "$ARCH" = "aarch64" ]; then
    ORIGIN="d2xpdm4jldf31f.cloudfront.net"
  else
    ORIGIN="d17k9fuiwb52nc.cloudfront.net"
  fi

  CLOUDPANEL_SOURCE_LIST=$(cat <<-END
deb https://no.archive.ubuntu.com/ubuntu/ jammy main
deb https://$ORIGIN/ $OS_CODE_NAME main
deb https://$ORIGIN/ $OS_CODE_NAME nginx
deb https://$ORIGIN/ $OS_CODE_NAME php-7.1
deb https://$ORIGIN/ $OS_CODE_NAME php-7.2
deb https://$ORIGIN/ $OS_CODE_NAME php-7.3
deb https://$ORIGIN/ $OS_CODE_NAME php-7.4
deb https://$ORIGIN/ $OS_CODE_NAME php-8.0
deb https://$ORIGIN/ $OS_CODE_NAME php-8.1
deb https://$ORIGIN/ $OS_CODE_NAME php-8.2
deb https://$ORIGIN/ $OS_CODE_NAME proftpd
deb https://$ORIGIN/ $OS_CODE_NAME varnish-7
END
)

CLOUDPANEL_APT_PREFERENCES=$(cat <<-END
Package: *
Pin: origin $ORIGIN
Pin-Priority: 1000
END
)

  echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list

  echo -e "$CLOUDPANEL_SOURCE_LIST" > /etc/apt/sources.list.d/packages.cloudpanel.io.list
  echo -e "$CLOUDPANEL_APT_PREFERENCES" > /etc/apt/preferences.d/00packages.cloudpanel.io.pref
  apt -y update
}

installMySQL()
{
  addAptSourceList

  if [ "$OS_NAME" = "Debian" ]; then
    case $DB_ENGINE in
      "MYSQL_5.7")
        echo "deb https://$ORIGIN/ $OS_CODE_NAME percona-server-server-5.7" > /etc/apt/sources.list.d/percona-mysql.list
        apt -y update
        DEBIAN_FRONTEND=noninteractive apt -y install percona-server-client-5.7 percona-server-server-5.7
      ;;
      "MYSQL_8.0")
        echo "deb https://$ORIGIN/ $OS_CODE_NAME percona-server-server-8.0" > /etc/apt/sources.list.d/percona-mysql.list
        apt -y update
        DEBIAN_FRONTEND=noninteractive apt -y install percona-server-client percona-server-server
      ;;
      "MARIADB_10.7")
        wget -qO- https://mariadb.org/mariadb_release_signing_key.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/mariadb.gpg
        echo "deb [arch=amd64,arm64] http://mirror.mariadb.org/repo/10.7/debian bullseye main" > /etc/apt/sources.list.d/mariadb.list
        apt -y update
        apt -y install mariadb-server
      ;;
      "MARIADB_10.8")
        wget -qO- https://mariadb.org/mariadb_release_signing_key.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/mariadb.gpg
        echo "deb [arch=amd64,arm64] http://mirror.mariadb.org/repo/10.8/debian bullseye main" > /etc/apt/sources.list.d/mariadb.list
        apt -y update
        apt -y install mariadb-server
      ;;
      "MARIADB_10.9")
        wget -qO- https://mariadb.org/mariadb_release_signing_key.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/mariadb.gpg
        echo "deb [arch=amd64,arm64] http://mirror.mariadb.org/repo/10.9/debian bullseye main" > /etc/apt/sources.list.d/mariadb.list
        apt -y update
        apt -y install mariadb-server
      ;;
      *)
        die "Database Engine $DB_ENGINE not supported."
      ;;
    esac
  else
    case $DB_ENGINE in
      "MYSQL_8.0")
        apt -y update
        DEBIAN_FRONTEND=noninteractive apt -y install mysql-client-8.0 mysql-server-8.0
      ;;
     "MARIADB_10.6")
       apt -y update
       apt -y install mariadb-server
     ;;
     "MARIADB_10.7")
       wget -qO- https://mariadb.org/mariadb_release_signing_key.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/mariadb.gpg
       echo "deb [arch=amd64,arm64] http://no.archive.ubuntu.com/ubuntu/ jammy main" > /etc/apt/sources.list.d/mariadb.list
       apt -y update
       apt -y install mariadb-server
      ;;
     "MARIADB_10.8")
       wget -qO- https://mariadb.org/mariadb_release_signing_key.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/mariadb.gpg
       echo "deb [arch=amd64,arm64] http://mirror.mariadb.org/repo/10.8/ubuntu/ jammy main" > /etc/apt/sources.list.d/mariadb.list
       apt -y update
       apt -y install mariadb-server
     ;;
     "MARIADB_10.9")
       wget -qO- https://mariadb.org/mariadb_release_signing_key.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/mariadb.gpg
       echo "deb [arch=amd64,arm64] http://mirror.mariadb.org/repo/10.9/ubuntu/ jammy main" > /etc/apt/sources.list.d/mariadb.list
       apt -y update
       apt -y install mariadb-server
     ;;
      *)
        die "Database Engine $DB_ENGINE not supported."
      ;;
      esac
  fi
}

setupCloudPanel()
{
  DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::="--force-overwrite" install -y cloudpanel
  local CLP_RUNNING=$(lsof -u^root -i:8443 -P -n -sTCP:LISTEN)
  if [ -z "${CLP_RUNNING}" ]; then
    die "${RED_TEXT_COLOR}CloudPanel couldn't be installed. Check the log above for errors that occurred in the install process.${RESET_TEXT_COLOR}"
  fi
  showSuccessMessage
}

showSuccessMessage()
{
  CLOUDPANEL_URL="https://$IP:8443"
  printf "\n\n"
  printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
  printf "${GREEN_TEXT_COLOR}The installation of CloudPanel is complete!${RESET_TEXT_COLOR}\n\n"
  printf "CloudPanel can be accessed now:${YELLOW_TEXT_COLOR} $CLOUDPANEL_URL ${RESET_TEXT_COLOR}\n"
  printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
}

cleanUp()
{
echo "hello"
}

setOSInfo
checkRequirements
setIp
setupRequiredPackages
generateLocales
removeUnnecessaryPackages
installMySQL
setupCloudPanel
cleanUp
