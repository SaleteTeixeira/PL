%{
#include "hash.h"
char* palavra;
Dic dicionario;
int i;

%}

%%
.*         {for(int i=0; i<yyleng; i++){
                memset(palavra,0,strlen(palavra));
                j = 0;

                while(yytext[i]!=',' && yytext[i]!=';' && yytext[i]!='.' && yytext[i]!=' ' && yytext[i]!='{' && yytext[i]!='}'){
                    palavra[j] = yytext[i];
                    j++; i++;
                }

                if(yytext[i]==',' || yytext[i]==';' || yytext[i]=='.' || yytext[i]==' ' || yytext[i]=='{' || yytext[i]=='}')
                    printf("%c",yytext[i]);
                
                if(palavra!=NULL && exists(dicionario,palavra)) {
                    palavra[j] = "\0";
                    j = 0;
                    printf("\\textbf{%s}\\footnote{%s}",palavra,getIngles(dicionario,palavra));
                }
                else printf("%s",palavra);
            }}
%%

void lexTexto(Dic dic){
    dicionario = dic;
    yylex();
}
