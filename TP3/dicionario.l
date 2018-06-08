%x variacoes

%{
#include "y.tab.h"
%}

%%

[ \t\n]                                     ;
\<td" "name=\"palavra\"\>.*\<\/td\>         { yytext[yyleng-5]='\0'; 
                                              yylval.text = yytext+19; return PALAVRA;
                                            }
\<td" "name=\"significado\"\>.*\<\/td\>     { yytext[yyleng-5]='\0'; 
                                              yylval.text = yytext+23; return SIGNIFICADO;
                                            }
\<td" "name=\"variacoes\"\>.*<\/td\>        { yytext[yyleng-5]='\0'; 
                                              yylval.text = yytext+21; return VARIACOES;
                                            }
\<td" "name=\"ingles\"\>.*\<\/td\>          { yytext[yyleng-5]='\0'; 
                                              yylval.text = yytext+18; return INGLES;
                                            }
\<td" "name=\"sinonimos\"\>.*\<\/td\>       { yytext[yyleng-5]='\0'; 
                                              yylval.text = yytext+21; return SINONIMOS;
                                            }
.                                           ;

%%
