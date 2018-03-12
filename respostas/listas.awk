BEGIN {FS=" "}

NF>0 {if ($6 ~ /^pos=verb.*/) verbos[$2]++;
      if ($6 ~ /^pos=noun.*/) substantivos[$2]++;
      if ($6 ~ /^pos=adjective.*/) adjetivos[$2]++;
      if ($6 ~ /^pos=adverb.*/) adverbios[$2]++}

END {filename="verbos.txt"; for(i in verbos) print verbos[i], i >>filename; close (filename); 
     filename="substantivos.txt"; for(i in substantivos) print substantivos[i], i >>filename; close (filename);
     filename="adjetivos.txt"; for(i in adjetivos) print adjetivos[i], i >>filename; close (filename);
     filename="adverbios.txt"; for(i in adverbios) print adverbios[i], i >>filename; close (filename)}
