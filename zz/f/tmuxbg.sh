tmuxbg() { 
# tmux source-file /data/data/com.termux/files/home/.tmux.conf; 
tmux source-file ~/.config/tmux/tmux.conf; 
tmux set-option -g status-style bg=colour$(printf %b "$((RANDOM%222))";); 
} 
