
wohtml() { 
mkdir -p $HOME/logs/wotd 2>/dev/null; 
time="$(date +%y_%m_%d)"; 
wotmp=$HOME/tmp/wotd_$time.log; 
[ -z $1 ]&& ext="word-of-the-day"||ext="thesaurus/$1"; 
command w3m -cols 800 -dump https://www.merriam-webster.com/$ext > $wotmp; 
( printf %b 'printf -v "w_w" "'; 
cat $wotmp|sed -n 39p|cut -f1 -d" "|tr -d "\n"; 
printf %b '";'; echo; ) > $HOME/logs/wotd_m.sh; 
( printf %b 'printf -v "w_t" "'; 
cat $wotmp|sed -n 42p|cut -f1 -d" "|tr -d "\n "; 
printf %b '";'; 
echo; ) >> $HOME/logs/wotd_m.sh; 
( printf %b 'printf -v "w_p" "'; 
cat $wotmp|sed -n 42p|cut -f2- -d" "|tr -d "\n "; 
printf %b '";'; echo; ) >> $HOME/logs/wotd_m.sh; 
( printf %b "printf -v "'w_m'" %b "; 
printf %q "$(sed -n 48p $wotmp)"; ) >> $HOME/logs/wotd_m.sh; 
cd $HOME/logs/wotd; 
wo="wotd_$(date +%Y_%m_%d)_$w_w"; wotd_m &>/dev/null; printf %b "$(figlet -f Roman $w_w|bat --theme Nord -ppfljava)\n$(printf %b "$w_m"|fold -sw 44|bat --theme Nord -ppflzig)\n\e[2m\n [\e[0m$(printf %b "$w_p"|bat -ppflr)\e[2m] > \e[96m$w_t    \e[2m\n\n\n\n"|\
aha -t "word of the day - $w_w" -b -y "margin:0;width:100%;overflow-x:hidden;
font-family:monospace;font-size:
clamp(2vmin,2.4vmin,.182em);
text-align:center;padding-top:
clamp(6vh,22vh,8em);margin-top:calc(12vh - 9ch);background:rgb($((RANDOM%88 + 8)),$((RANDOM%88 + 8)),$((RANDOM%88 + 8)));" > $wo.html; 
sed -i '6i<meta name="viewport" content="width=device-width, initial-scale=1.0" />' $wo.html; 
cd $HOME/gh/aeniks.github.io/wotd; 
cp $HOME/logs/wotd/$wo.html $HOME/gh/aeniks.github.io/wotd/; 
cp -f $wo.html index.html; 
git add --all; git commit --all -m $(date +%F_%H_%M); git push; 
sleep 4; rm $wo.png; 
ARGS=(
--data-urlencode "key=408f3d" \
--data-urlencode "dimension=1600x1600" \
--data-urlencode "device=mobile" \
--data-urlencode "format=png" \
--data-urlencode "cacheLimit=0" \
--data-urlencode "delay=1000" \
--data-urlencode "zoom=200" \
--data-urlencode "url=https://aeniks.github.io/wotd"
)
if [[ -n "$SECRET_PHRASE" ]]; then HASH=$(echo -n $URL$SECRET_PHRASE | md5sum | cut -d ' ' -f 1); ARGS+=(--data-urlencode "hash=$HASH"); fi
curl -Gs "https://api.screenshotmachine.com" "${ARGS[@]}" > $wo.png; 
cp -f $wo.png wotd.png; 
git add --all; git commit --all -m $(date +%F_%H_%M); git push; 
}; 
wotd_m() { time=$(date +%y_%m_%d); [ -e $HOME/logs/wotd/wotd_m_${time}.sh ] || . $start/crons/wotd_m.sh; . $HOME/logs/wotd_m.sh; printf %b "$yellow$w_w$pink > $re[$cyan$w_p${re}]$pink > $blue$w_t$pink >$re$dim \n\b\b$w_m"|bat -ppljava; };
wohtml 
