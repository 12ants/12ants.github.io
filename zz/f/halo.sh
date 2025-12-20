#!/data/data/com.termux/files/usr/bin/bash
# figlet -f DOS_Rebel -c -w $COLUMNS "hello!"; 
## 
halo() {
printf "\e[?25l\e[H"; 
unset h; declare h array;
h+=('░███                ░███  ░███          ░███')
h+=('░███                ░███  ░███          ░███')
h+=('░███████    ██████  ░███  ░███   ██████ ░███')
h+=('░███░░███  ███░░███ ░███  ░███  ███░░███░███')
h+=('░███ ░███ ░███████  ░███  ░███ ░███ ░███░███')
h+=('░███ ░███ ░███░░░   ░███  ░███ ░███ ░███░░░ ')
h+=('░███ ░███ ░░██████  ░████ ░████░░██████  ███')
h+=('░░░  ░░░   ░░░░░    ░░░░  ░░░░  ░░░░░░  ░░░ ')
mm="$((COLUMNS/2-26))"; 
for i in {1..111}; do printf "\e[38;5;${i}m\e[B"; 
for i in {0..7}; do printf "\e[${mm}G${h[i]}\e[B"; done
printf "\n\e[8A"; read -n1 -t.1 -res x; 
[ "$x" ]&&break; done; 
for i in {111..180}; do printf "\e[38;5;${i}m\e[B"; 
for i in {0..7}; do printf "\e[${mm}G${h[i]}\e[B"; done
printf "\e[8A"; read -n1 -t.1 -res x; 
printf "\e[$((RANDOM%5))A\e[$((RANDOM%4))B"
[ "$x" ]&&break; done; 
for i in {180..255}; do printf "\e[38;5;${i}m\n"; 
ll=$((mm-RANDOM%2+RANDOM%2))
for i in {0..7}; do printf "\e[${ll}G${h[i]}\e[B"; done
printf "\n\e[8A"; read -n1 -t.1 -res x; 
[ "$x" ]&&break; done; 

printf "\e[$((COLUMNS/2-RANDOM%6))G"; 

printf "\e[?25h\e[18B\n\n\n\n\n\n\e[$((COLUMNS/2-16))G";
read -n1 -srep "  ok [Y/n]" "f"; [ "$f" ]||\
printf "\e[$((COLUMNS/2-16))G  \e[7m   ok   \e[0m \n\n\n\n\n\n"
}



