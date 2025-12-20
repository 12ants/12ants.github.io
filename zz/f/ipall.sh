#!/bin/bash 
alias ipa='iplocall=($(ip -brief a show scope global up|\
cut -c22-|tr -s " \n" "\n"; )); printf %b "\n
${iplocall[*]}\n"|batcat -ppflr; '; 

