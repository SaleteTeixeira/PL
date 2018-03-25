BEGIN {FS=" "}

NF>0 {if ($4 ~ /^V/) verbos[$2]++;
      if ($4 ~ /^N/) substantivos[$2]++;
      if ($4 ~ /^A/) adjetivos[$2]++;
      if ($4 ~ /^R/) adverbios[$2]++ }

END {for(i in verbos) print verbos[i], i | "sort -n -r > verbos.txt";  
     for(i in substantivos) print substantivos[i], i | "sort -n -r > substantivos.txt";
     for(i in adjetivos) print adjetivos[i], i | "sort -n -r > adjetivos.txt";
     for(i in adverbios) print adverbios[i], i | "sort -n -r > adverbios.txt"}
