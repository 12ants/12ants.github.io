#!/bin/bash
[ "$PREFIX" ]||sudo='sudo'; $sudo apt update 2>/dev/null|tail -n1|cut -f 1 -d "."|tr -d "\n" > $HOME/logs/aptup.log && printf  "[96m @[0m $(date)[0m" >> $HOME/logs/aptup.log; 
