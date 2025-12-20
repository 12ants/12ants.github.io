note() {
echo -e "\n\n -- syncing...\n\n"; 
gh gist edit 4b5c805719fe0855a10f9d4fbdd197e1||gh gist edit 4b5c805719fe0855a10f9d4fbdd197e1||
(read -n1 -rep "-- login with token? [Y/n] " "yn"; [ "$yn" ]&& return; 
printf "\n\n$c2 ants folder:"; read -rep " " -i "$ants" "ants"; 
gpg --pinentry-mode loopback -o "~/gh.txt" -d "$ants/sh/config/gh_aeniks.gpg"; 
gh auth login --with-token < "~/gh.txt"; printf "$c2 "; rm ~/gh.txt;
gh auth status&& printf "\n\n\e[42m OK \e[0m\n\n"; 
printf "\n  try again \n\n"; )
}
