op ()
{
    op="$(tmux='-tmux -h'; command ls --color -Ap | fzf$tmux -h --inline-info --expect q -i --ansi --walker dir,file --border none  --bind 'left:execute(cd ..)+reload(ls)' --preview 'batcat -pf {} 2>/dev/null||command ls -shp --time-style=+%X -lG --color|\
cut -c 20-;')";
    op="$(realpath $op)";
    optype="$(file -bs "$op")";
    if [ "$optype" = "directory" ]; then
        cd "$op" && op;
    fi
}
