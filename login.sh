



## console login default
sudo systemctl set-default multi-user.target
## gui def
## sudo systemctl set-default graphical.target

## Message before login

## echo "Hello login" > /etc/issue /etc/ssh/sshd-banner
## echo "Banner /etc/ssh/sshd-banner" > /etc/ssh/sshd-config

apt install -y ssh fortune cowsay

echo '

_____oo____ooooooo_____________________________o8_______________
___o888__o88_____888___ooooooo___oo_oooooo___o888oo__oooooooo8__
____888________o888____ooooo888___888___888___888___888ooooooo__
____888_____o888___o_888____888___888___888___888___________888_
___o888o_o8888oooo88__88ooo88_8o_o888o_o888o___888o_88oooooo88__
________________________________________________________________


' >> /etc/issue

/etc/init.d/ssh restart 

## Message after login
cd ~
echo "fortune | cowsay -pn" >> .bashrc 
tput blink
echo '
clear

read -ep "
------------------------------------
------------------------------------
---------- Start windows ? [Y/n] " yn;
if [ "$yn" != "${yn#[Nn]}" ]; then
echo "${re} nope ";echo -e ;
else ###### ---- [YES] ----- ######
startx
fi
' >> /etc/profile 

echo "
        hello traveler

" > /etc/motd 

/etc/init.d/ssh restart 

