#!/bin/bash
## install tmux
apt install -y \
autoconf libevent \
ncurses pkg-config \
automake bison byacc; 
mkdir $HOME/gh 2>/dev/null; 
cd $HOME/gh; 
gh repo clone tmux/tmux;
cd tmux; sh autogen.sh; ./configure; 
make; $sudo make install; 
ln -s $HOME/gh/tmux/tmux -t $PREFIX/bin; 
