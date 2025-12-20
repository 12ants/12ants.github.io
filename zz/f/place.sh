
place() { 
local IFS=$'\n\t '; 
place=($(timeout 6 termux-location|tr -d '""}{[:alpha:],: ';)); 
[ "$place" ] && \
(printf %b "\n--------\n"; date +%c; printf %b "--------\n"; 
curl -sL "https://api.geoapify.com/v1/geocode/reverse?lat=${ll}&lon=${ll[1]}&lang=en&limit=1&format=json&apiKey=ab9bd0f92c7f48b49bf3ba01492b7d08"|jq --indent 0|grep -e "formatted"|cut -f4 -d'"'; 

printf %b "--------\n\n"; ) | tee -a $HOME/logs/place.log || \
printf %b "\n------\n$(date +%c; ) -- nope\n------\n\n" | tee -a $HOME/logs/place.log; }; 
alias 12place='place'; 
