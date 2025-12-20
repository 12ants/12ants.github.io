
mkd() {
printf %b "\n\n\n\n\e[4A\n $c2 new folder?$re  "; 
read -ei "$PWD/$1" "folder";
mkdir -p $folder -m 775;
# chown "$SUDO_USER":"$USER" "$folder";
cd $folder; printf %b "\n\t $cyan$bold> $pink$PWD$cyan <$re\n\t * * * *\n"; 
ls -caklhuptr --group-directories-first; 
}; 

