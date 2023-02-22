echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10-installer;
############ ROOT AUTOCOMPLETE
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

function b_alias { tput sc; tput cup 0 0; tput setaf 5; echo -e "${netip} / ${pubip}"; tput rc; } ; PROMPT_COMMAND=b_alias;

###############################################

" >> ~/.bash_aliases;