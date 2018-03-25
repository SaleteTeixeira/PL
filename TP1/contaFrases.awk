BEGIN {FS=" "}
$2 ~ /^\.$/ {conta++}
END {print conta}
