df2() { local IFS=$'\n\t '; df=($(df -H|grep -E "storage|Size"|tr -s " " " "|cut -f2-6 -d" ")); dflines="$${#df[*]}"; aa=0; kk=0; for i in ${df[*]}; do for a in {4,0,1,2,3}; do printf %b "${df[((a+aa))]} "; ((kk++)); done; aa=$kk; printf %b "\n\n "; done|column --table --table-columns-limit 5 --output-separator " | "; 

# case $o in 0) oc=28;; 1) oc=196;; 2) oc=196;; 3) oc=166;; 4) oc=130;; 5) oc=130;; 6) oc=94;; 7) oc=100;; 8) oc=64;; 9) oc=64;; esac; 

}; 

