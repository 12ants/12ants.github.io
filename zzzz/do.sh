#!/usr/bin/env bash
###################
###################
printf %b "$PWD"|grep -qe "zzzz"&&printf %b "folder: zzzz/ exists \t [ok]"||return 1||break;  
printf %b "\n--------\n"; 
###################
################### MAKE FOLDERS
for i in "bin" "gh" "logs" ".config"; do 
mkdir -p "${HOME}/${i}" 2>/dev/null; done; 
printf %b "folders made         \t [ok]\n"; 
printf %b "--------\n"; 
###################
################### SET VARIABLES 
zzzz_fold=($(command ls --color=never -p1 ./config|grep -e "/")); 
zzzz_file=($(command ls --color=never -p1 ./config|grep -v "/")); 
zzzz_home=($(command ls --color=never -p1 -A ./config/.home)); 
###################
################### LINK CONFIG FILES
for i in ${zzzz_fold[*]}; do ln -s ${PWD}/config/${i}/* -t ${HOME}/.config/${i} -b; done; 
for i in ${zzzz_file[*]}; do ln -s ${PWD}/config/${i} -t ${HOME}/.config -b; done; 
for i in ${zzzz_home[*]}; do ln -s ${PWD}/config/.home/${i} -t ${HOME} -b; done; 
###################
###################
printf %b "links made          \t [ok]\n"; 
###################
################### DONE 
printf %b "--------\n"; 
printf %b "done!               \t [ok] \n\n"; 
###################
###################
