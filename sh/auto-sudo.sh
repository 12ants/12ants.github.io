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
function prompt_command {
#  prompt_x is where to position the cursor to write the clock
let prompt_x=$(tput cols)-40
#  Move up one; not sure why we need to do this, but without this, I always
tput sc; tput cup 0 ${prompt_x}; tput setaf 4;
echo -e "                                ";
tput cup 0; ${prompt_x} 
echo -e "${netip} / ${pubip}"; tput rc
}
PROMPT_COMMAND=prompt_command
###############################################

" >> ~/.bash_aliases;
