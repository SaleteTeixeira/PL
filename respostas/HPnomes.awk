BEGIN {FS=" "}
$5 ~ /NP/ {array[$2]++}
END {for (i in array) print array[i], i | "sort -n -r > personagensHP.txt"} 
