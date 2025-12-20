#!/bin/bash
[ -e $HOME/.config/tmux/plugins ] || mkdir -m 775 -p $HOME/.config/tmux/plugins 2>/dev/null; 
####
git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm; 
cd $HOME/.config/tmux/plugins/tpm; 
tmux set -g @plugin 'tmux-plugins/tpm' 
# tmux set -g @plugin 'tmux-plugins/tmux-sensible' 
tmux run "$HOME/.config/tmux/plugins/tpm/tpm"
tmux source $HOME/.config/tmux/tmux.conf 
cd $OLDPWD; 
