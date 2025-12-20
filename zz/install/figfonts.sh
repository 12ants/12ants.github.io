#!/bin/bash
## install tmux
hash sudo && sudo=sudo; 
hash figlet || $sudo apt install -y figlet; 
$sudo mkdir $PREFIX/share 2>/dev/null; 
$sudo mv $PREFIX/share/figlet $HOME/tmp/figlet2 -b 2>/dev/null; 
$sudo mkdir -pm 775 $PREFIX/share/figlet; 
[ "$sudo" ] && $sudo chown 1000: $PREFIX/share/figlet; 
$sudo ln -s $HOME/.config/12/zz/i/figfonts/* -t $PREFIX/share/figlet 2>/dev/null; 
