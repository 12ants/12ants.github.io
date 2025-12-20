lstheme() { 
vt="$(vivid themes|fzf)"; 
export vt; 
LS_COLORS="$(cat $HOME/88/c/lsc/${vt}.sh)";
export LS_COLORS; 
reset -Q;
exec bash; 
}; 
