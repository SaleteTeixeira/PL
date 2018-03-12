BEGIN {FS=" "}
NF==0 {conta++}
END {print conta}
