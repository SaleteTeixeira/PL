%{
#include "hash.h"
char* atual=NULL;
char* antiga=NULL;
char* juntas=NULL;
char* pontAnt;
char* pontAtual;
char** existentes;
char* aux;
int i, j, ocup, tamArray=0, existe;
Dic dicionario;

int pontuacaoDif(int i){
    return (i<yyleng && yytext[i]!=',' && yytext[i]!=';' &&
            yytext[i]!='.' && yytext[i]!=' ' && yytext[i]!='{' &&
            yytext[i]!='}' && yytext[i]!=':' && yytext[i]!=')' &&
            yytext[i]!='(' && yytext[i]!='!' && yytext[i]!='?' &&
            yytext[i]!='\\'&& yytext[i]!='[' && yytext[i]!=']' &&
            yytext[i]!='/');
}

int pontuacaoIgual(int i){
    return (i<yyleng || yytext[i]==',' || yytext[i]==';' ||
            yytext[i]=='.' || yytext[i]==' ' || yytext[i]=='{' ||
            yytext[i]=='}' || yytext[i]==':' || yytext[i]==')' ||
            yytext[i]=='(' || yytext[i]=='!' || yytext[i]=='?' ||
            yytext[i]=='\\'|| yytext[i]=='[' || yytext[i]==']'||
            yytext[i]=='/');
}

%}

%%

\\end{document}     {   printf("\\begin{appendices}\n");
                        printf("\\chapter{Dicionário Cinematográfico}\n");
                        printf("\\begin{table}[h!]\n");
                        printf("\\begin{center]\n");
                        printf("\\begin{tabular}{c|c|c|c|c}\n";)
                        printf("\\textbf{Palavra} & \\textbf{Significado} & \\textbf{Variações}");
                        printf(" & \\textbf{Designação em Inglês} & \\textbf{Sinónimos}\\\n");
                        printf("\\hline\n");
                        for(i=0; i<tamArray; i++){
                            printInfo(dicionario,existentes[i]);
                        }
                        printf("\\end{tabular}\n");
                        printf("\\caption{Tabela ilustrativa do Dicionário}\n");
                        printf("\\end{center}\n");
                        printf("\\end{table}\n");
                        printf("\\end{appendices}\n");
                        printf("\\end{document}");
                    }

.*         {    for(int i=0; i<yyleng; i++){
                    memset(atual,0,strlen(atual));
                    memset(pontAtual,0,strlen(pontAtual));
                    j = 0;
                    ocup = 0;

                    while(pontuacaoDif(i)){
                        atual[j] = yytext[i];
                        j++; i++;
                    }

                    while(pontuacaoIgual(i)){
                       pontAtual[ocup] = yytext[i];
                       i++; ocup++;
                    }
                    
                    if(exists(dicionario,atual)) {
                        printf("\\textbf{%s}\\footnote{%s}",atual,getIngles(dicionario,atual));
                        existe = 0;
                        strcpy(aux,getPalavra(dicionario,atual));
                        for(int k=0; k<tamArray && !existe; k++){
                            if(strcmp(existentes[tamArray],aux)==0) existe=1;
                        }
                        if(!existe){
                            strcpy(existentes[tamArray],aux);
                            tamArray++;
                        }
                        memset(aux,0,strlen(aux));
                    }
                    else {
                        if(antiga!=NULL){
                            strcat(antiga,pontAnt,juntas);
                            strcat(juntas,atual,juntas);
                            if(exists(dicionario,juntas)) {
                                printf("\\textbf{%s}\\footnote{%s}",juntas,getIngles(dicionario,juntas));
                                existe = 0;
                                strcpy(aux,getPalavra(dicionario,juntas));
                                for(int k=0; k<tamArray && !existe; k++){
                                    if(strcmp(existentes[tamArray],aux)==0) existe=1;
                                }
                                if(!existe){
                                    strcpy(existentes[tamArray],aux);
                                    tamArray++;
                                }
                                memset(aux,0,strlen(aux));
                            }
                            else{
                                printf("%s", antiga);
                                printf("%s", pontAnt);
                            }
                        }
                        memset(antiga,0,strlen(antiga));
                        memset(juntas,0,strlen(juntas));
                        memset(pontAnt,0,ocup);
                        strcpy(antiga,atual);
                        strcpy(pontAnt,pontAtual);
                    }
                }
                if(!exists(dicionario,atual))
                    printf("%s", atual);
                printf("%s", pontAtual);
            }
%%

void lexTexto(Dic dic){
    dicionario = dic;
    yylex();
}
