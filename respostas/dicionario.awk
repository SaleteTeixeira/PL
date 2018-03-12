BEGIN {FS=" "}
NF>0 {print $3, "\t" $5, "\t" $2}
END {}
