#!/bin/bash
## cp fonts - fig
[ "$PREFIX" ]&& alias sudo=' '; 
[ -z "$PREFIX" ]&& sudo=sudo && $PREFIX="/usr" ; 
from="$start/config/figlet/fonts"; to="$PREFIX/share/figlet"; 
#read -rep "copy font-files from: " -i "$HOME/start/config/figlet/fonts" "from";
#read -rep "to: " -i "$PREFIX/share/figlet" "to";
cp ${from}/* ${to}/||$sudo cp ${from}/* ${to}/


#mkdir -p -m 775 $PREFIX/usr/share/figlet 2>/dev/null; cp $HOME/start/config/figlet/fonts/* $PREFIX/usr/share/figlet/ 2>/dev/null; 
mkdir -p -m 775 $PREFIX/share/figlet 2>/dev/null||\
$sudo mkdir -p -m 775 $PREFIX/share/figlet 2>/dev/null; 
cp $HOME/start/config/figlet/fonts/* $PREFIX/share/figlet/ 2>/dev/null||\
$sudo cp $HOME/start/config/figlet/fonts/* $PREFIX/share/figlet/ 2>/dev/null; 
$sudo chmod 775 $PREFIX/share/figlet -R 2>/dev/null; 
figlist > $HOME/figzz.sh; 
