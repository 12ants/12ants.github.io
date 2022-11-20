#/bin/bash
##################################
#### -- LOADING ANIMATION -- ####
####
green="tput setaf 2"
red="tput setaf 1"
def="tput sgr0"
dim="tput dim"
clear;
BLA_metro=( 1 '   o0' "   0o" '   o0' '   0o' )
declare -a BLA_active_loading_animation
BLA::play_loading_animation_loop() {
while true ; do
for frame in "${BLA_active_loading_animation[@]}" ; do
${green} ; ${dim} ; tput civis ;
#printf "\r%s" "    [ ${frame} ]"
printf "\r%s ]"; printf "\r%s" "${frame}"; ${def}; printf "\r%s" "  ["; tput cuf 2 ; printf "] "; 
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
sudo apt update -y &> /dev/null ; apt install -qq -y curl tar unzip &> /dev/null ;
tput cub 4 ; ${green}; echo "OK"
${green}; echo -e "\v\t\v done! \v\v"
BLA::stop_loading_animation&> /dev/null
sleep 1;


