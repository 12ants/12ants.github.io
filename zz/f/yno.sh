
yno() { printf %b "\n\n\e[A  -- Continue? ";printf %b "\e[0\[\e[2mY\e[0m/\e[2mn\e[0m]"; read -n1 -rsp ' ' 'yno'; [[ "$yno" == "${yno#[a-xzA-XZ10-9]}" ]] && printf %b "ok\n\n" || ( printf %b "nope\n\n"; return 1 2>/dev/null; ); }; 
