BEGIN{FS=" \t"}

$2 ~ "D" && $3 ~ /^[A-Z]/ {determinante[det++] = $3; srand(); dr = int(rand()*det)}
$2 ~ "N" {nomes[n++] = $3; srand(); nr = int(rand()*n)}
$2 ~ "V" && $3 ~ /^[a-z]/ {verbos[verb++] = $3; srand(); vr = int(rand()*verb)}
$2 ~ "AQ" && $3 ~ /^[a-z]/ {adjetivo[adj++] = $3; srand(); ar = int(rand()*adj)}

END{srand(); print determinante[dr], nomes[nr], verbos[vr], adjetivo[ar]}

