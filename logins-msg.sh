



## console login default
sudo systemctl set-default multi-user.target
## gui def
## sudo systemctl set-default graphical.target

## Message before login

## echo "Hello login" > /etc/issue /etc/ssh/sshd-banner
## echo "Banner /etc/ssh/sshd-banner" > /etc/ssh/sshd-config

apt install -y ssh fortune cowsay

echo "Welcome to 12ants.com -- today is \d \t @ \n" >> /etc/issue

/etc/init.d/ssh restart 

## Message after login
## echo "fortune | cowsay -pn" >> ~.bashrc 
echo "fortune | cowsay -pn
" >> /etc/profile 

echo "hello" > /etc/motd 

ssh restart
