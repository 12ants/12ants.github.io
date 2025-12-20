printf %b '
\e[1;4;96mCharacter classes\e[0m
.	any character except newline
\w\d\s	word, digit, whitespace
\W\D\S	not word, digit, whitespace
[abc]	any of a, b, or c
[^abc]	not a, b, or c
[a-g]	character between a & g
\e[1;4;96mAnchors\e[0m
^abc$	start / end of the string
\b\B	word, not-word boundary
\e[1;4;96mEscaped characters\e[0m
\.\*\\	escaped special characters
\t\n\r	tab, linefeed, carriage return
\e[1;4;96mGroups & Lookaround\e[0m
(abc)	capture group
\1	backreference to group #1
(?:abc)	non-capturing group
(?=abc)	positive lookahead
(?!abc)	negative lookahead
\e[1;4;96mQuantifiers & Alternation\e[0m
a*a+a?	0 or more, 1 or more, 0 or 1
a{5}a{2,}	exactly five, two or more
a{1,3}	between one & three
a+?a{2,}?	match as few as possible
ab|cd	match ab or cd
'; 
