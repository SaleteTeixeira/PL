BEGIN {
    FS=" ";
    ORS=" ";
    filename=ARGV[2];
    beginlatex(); 
    IGNORECASE=1;
}

$2 ~ /[õ,ó]/ {gsub(/[õ,ó]/,"o")}
$2 ~ /[ã,à,á]/ {gsub(/[ã,à,á]/,"a")}
$2 ~ /ç/ {gsub(/ç/,"c")}
$2 ~ /é/ {gsub(/é/,"e")}
$2 ~ /í/ {gsub(/í/,"i")}
$2 ~ /[_,{,}]/ {gsub(/[_,{,}]/," ")}
NF>0 {print $2 >> filename}
NF==0 {print "\n \\par" >> filename}

END{
    print "\n\\end{document}" >> filename;close(filename);
    str = "texi2pdf " filename;
    system(str);
}

function beginlatex(){
    print "\\documentclass{article}\n\\usepackage[utf8]{inputenc}\n\\usepackage[portuguese,brazil,english]{babel}\n\\title{PL}\n\\author{Sérgio // Salete // Sofia }\n\\date{March 2018}\n\\begin{document}\n\\maketitle\n\\section{Texto ", ARGV[1] , " }\n\\par" >> filename;
}
