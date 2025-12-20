
fs=($(df -H | grep -vE "tmpfs|passthrough" | tr -s " " " " | grep -E "sdcard/default|storage|Size"))    

gum style --border normal --margin "1 2" --padding "0" "$(printf %b "\e[7m\e[8m_\e[0;7m${fs[*]:0:7} \e[0m\n\e[8m_\e[0m${fs[*]:7:6}\n\n"|column --table --table-columns-limit 6 --output-separator ' | ')"
