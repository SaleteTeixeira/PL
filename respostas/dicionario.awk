BEGIN {FS=" ";
       print "<htlm>\n\t<body>\n\t<table border='1'><thead><tr><th>lema</th><th>pos</th><th>palavra derivada</th></tr></thead><tbody>"}

NF>0 && $3 ~ /^[A-Za-z]+$/ {print "<tr><td>" $3 "</td><td>" $5 "</td><td>" $2 "</td></tr>" | "sort | uniq"}

END {print "</tbody></table>\n</body>\n</html>"}
