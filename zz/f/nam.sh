nam() { patt="${*:2}"; man -c $1|col -xb|ul|bat -ppfljava|less $([ $patt ] && printf %b "--pattern ${patt}"); }; 
