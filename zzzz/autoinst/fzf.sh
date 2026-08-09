#!/bin/bash
## gh fzf
hash sudo 2>/dev/null&& sudo=sudo; 
mkdir ~/gh 2>/dev/null; 
mkdir ~/bin 2>/dev/null; 
hash git 2>/dev/null||$sudo apt install git; 
####
hash fzf 2>/dev/null && $sudo apt remove -y fzf &>/dev/null; 
####
rm -fr $HOME/gh/fzf 2>/dev/null; 
####
git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/gh/fzf; 
####
${HOME}/gh/fzf/install --all --no-fish --no-zsh; 
####
$sudo ln -s $HOME/gh/fzf/bin/fzf* -t $PREFIX/bin/
####
