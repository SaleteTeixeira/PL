BEGIN {FS=" ";
       ORS=" ";
       filename=ARGV[2]}

NF>0 {print $2 >> filename}
NF==0 {print "\n" >> filename}

END{close(filename)}
