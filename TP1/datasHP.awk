BEGIN {FS = " "; hp1 = 0; hp2 = 0}

FILENAME == "harrypotter1" {if(hp1 < 5 && NF == 0){
                                hp1++};
                            if(hp1 == 5 && $2 ~ /^[0-9]{4}$/){
                                datas[$2]}
                           }

FILENAME == "harrypotter2" {if(hp2 < 1 && NF == 0) {
                                hp2++}; 
                            if(hp2 == 1 && $2 ~ /^[0-9]{4}$/) {
                                datas[$2]}
                           }

END {for(i in datas) print i  | "sort -n > datas.txt"}
