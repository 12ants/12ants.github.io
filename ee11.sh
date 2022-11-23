
# MAKE COMMANDS:
# WANIP = GET PUBLIC IP
# LANIP = GET LOCAL IP
alias wanip='dig @resolver4.opendns.com myip.opendns.com +short' 
alias wanip4='dig @resolver4.opendns.com myip.opendns.com +short -4'
alias wanip6='dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6'
alias lanip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
echo "LOCAL IP:"; tput blink; tput cuu1; echo -e "\t Fetching..."; tput cuu1; lanip;
