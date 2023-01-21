



## console login default
sudo systemctl set-default multi-user.target
## gui def
## sudo systemctl set-default graphical.target

## Message before login

## echo "Hello login" > /etc/issue /etc/ssh/sshd-banner
## echo "Banner /etc/ssh/sshd-banner" > /etc/ssh/sshd-config

apt install -y ssh fortune cowsay

echo '
echo "______/\\\____/\\\\\\\\\_____________________________________________________________        ";
echo " __/\\\\\\\__/\\\///////\\\___________________________________________________________       ";
echo "  _\/////\\\_\///______\//\\\___________________________________/\\\___________________      ";
echo "   _____\/\\\___________/\\\/____/\\\\\\\\\_____/\\/\\\\\\____/\\\\\\\\\\\__/\\\\\\\\\\_     ";
echo "    _____\/\\\________/\\\//_____\////////\\\___\/\\\////\\\__\////\\\////__\/\\\//////__    ";
echo "     _____\/\\\_____/\\\//__________/\\\\\\\\\\__\/\\\__\//\\\____\/\\\______\/\\\\\\\\\\_   ";
echo "      _____\/\\\___/\\\/____________/\\\/////\\\__\/\\\___\/\\\____\/\\\_/\\__\////////\\\_  ";
echo "       _____\/\\\__/\\\\\\\\\\\\\\\_\//\\\\\\\\/\\_\/\\\___\/\\\____\//\\\\\____/\\\\\\\\\\_ ";
echo "        _____\///__\///////////////___\////////\//__\///____\///______\/////____\//////////__";


Welcome to 12ants.com -- today is \d \t @ \n' >> /etc/issue

/etc/init.d/ssh restart 

## Message after login
## echo "fortune | cowsay -pn" >> ~.bashrc 
echo 'fortune | cowsay -pn

read -ep "  ----------${re} Start windows ? [Y/n] " yn;
if [ "$yn" != "${yn#[Nn]}" ]; then
echo "${re} nope ";echo -e ;
else ###### ---- [YES] ----- ######
startx
fi
' >> /etc/profile 

echo "hello" > /etc/motd 
