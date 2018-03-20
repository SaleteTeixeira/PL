BEGIN {FS=" ";
       ORS=" ";
       filename=ARGV[2];
       beginlatex();}

NF>0 {print $2 >> filename}
NF==0 {print "\n\\par" >> filename}

END{print "\\end{document}" >> filename;close(filename)}

function beginlatex(){
    print "\\documentclass[12pt]{article}\n \\usepackage[portuges]{babel}\n\\usepackage[utf8x]{inputenc}\n\\usepackage{mathtools}\n\\usepackage{graphicx}\n\\usepackage[colorinlistoftodos]{todonotes}\n\\usepackage{tikz}\n\\usepackage{hyperref}\n\\usetikzlibrary{calc,trees,positioning,arrows,chains,shapes.geometric,%    decorations.pathreplacing,decorations.pathmorphing,shapes,%    matrix,shapes.symbols}\n\\usepackage{listings}\n\\usepackage{color}\n\\usepackage{titlesec}\n\\usepackage{float}\n\\usepackage{indentfirst}\\setlength{\\parindent}{0.5cm}\n\\definecolor{mygreen}{rgb}{0,0.6,0}\\definecolor{mygray}{rgb}{0.5,0.5,0.5}\\definecolor{mymauve}{rgb}{0.58,0,0.82}\\lstset{ %  backgroundcolor=\\color{white},   % choose the background color; you must add \n\\usepackage{color} or \n\\usepackage{xcolor}; should come as last argument  basicstyle=\\footnotesize,        % the size of the fonts that are used for the code  breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace  breaklines=true,                 % sets automatic line breaking  captionpos=b,                    % sets the caption-posibetion to bottom  commentstyle=\\color{mygreen},    % comment style  deletekeywords={...},            % if you want to delete keywords from the given language  escapeinside={\\%*}{*)},          % if you want to add LaTeX within your code  extendedchars=true,              % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8  frame=single,	                   % adds a frame around the code  keepspaces=true,                 \n% keeps spaces in text, useful for keeping indentation of code (possibly needs columns=flexible)  keywordstyle=\\color{blue},       % keyword style  language=Octave,                 % the language of the code  morekeywords={*,...},           % if you want to add more keywords to the set  numbers=left,                    % where to put the line-numbers; possible values are (none, left, right)  numbersep=5pt,                   % how far the line-numbers are from the code  numberstyle=\\tiny\\color{mygray}, % the style that is used for the line-numbers  rulecolor=\\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))  showspaces=false,                % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'  showstringspaces=false,          % underline spaces within strings only  showtabs=false,                  % show tabs within strings adding particular underscores  stepnumber=2,                    % the step between two line-numbers. If it's 1, each line will be numbered  stringstyle=\\color{mymauve},     % string literal style  tabsize=2,	                   % sets default tabsize to 2 spaces  title=\\lstname                   % show the filename of files included with \\lstinputlisting; also try caption instead of title}\n\\begin{document}\n\\setcounter{tocdepth}{4}\\setcounter{secnumdepth}{4}\\begin{titlepage}\\newcommand{\\HRule}{\\rule{\\linewidth}{0.3mm}} % Defines a new command for the horizontal lines, change thickness here\\center\\textsc{\\large Universidade do Minho}\\[0.3cm] % Name of your university/college\\textsc{\\large Mestrado Integrado em Engenharia Informática}\\[0.3cm] % Major heading such as course name\\textsc{\\large Departamento de Informática}\\[1.5cm] % Major heading such as course name\\textsc{\\Large Sistemas de Representação de Conhecimento e Raciocínio}\\[0.3cm] \\HRule \\[0.4cm]{ \\huge \\bfseries Exercício 1}\\\\[0.4cm] % Title of your document\\HRule \\\\[1.5cm]\n\\Large Isabel Sofia da Costa Pereira \\textsc{A76550}\n\\José Francisco Gonçalves Petejo e Igreja Matos \\textsc{A77688}\n\\Maria de La Salete Dias Teixeira \\textsc{A75281}\\Tiago Daniel Amorim Alves \\textsc{A78218}\\\\[3cm]------------------------------------------------------------------------{\\large 18 de Março de 2018}\\\\[2cm]\\vfill % Fill the rest of the page with whitespace\\end{titlepage}" >> filename;
}