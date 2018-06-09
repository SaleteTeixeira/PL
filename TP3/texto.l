%{
#include "hash.h"
char* copia;
char* atual;
char* antiga;
char* juntas;
char* pontAnt;
char* pontAtual;
char** existentes;
char* aux;
int i, j, ocup, tamArray=0, existe, print=0;
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
    return (i<yyleng && (yytext[i]==',' || yytext[i]==';' ||
            yytext[i]=='.' || yytext[i]==' ' || yytext[i]=='{' ||
            yytext[i]=='}' || yytext[i]==':' || yytext[i]==')' ||
            yytext[i]=='(' || yytext[i]=='!' || yytext[i]=='?' ||
            yytext[i]=='\\'|| yytext[i]=='[' || yytext[i]==']'||
            yytext[i]=='/'));
}

int textowrap (void ){
    return 1;
}

%}

%%

\\end\{document\}     { printf("\\begin{appendices}\n");
                        printf("\\chapter{Dicionário Cinematográfico}\n");
                        printf("\\begin{table}[h!]\n");
                        printf("\\begin{center]\n");
                        printf("\\begin{tabular}{c|c|c|c|c}\n");
                        printf("\\textbf{Palavra} & \\textbf{Significado} & \\textbf{Variações}");
                        printf(" & \\textbf{Designação em Inglês} & \\textbf{Sinónimos}\\\\\n");
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
                    free(atual);
                    free(copia);
                    free(pontAtual);

                    j = 0;
                    ocup = 0;
                    if(i!=0) i--;

                    atual = (char*) malloc(yyleng*sizeof(char));
                    while(pontuacaoDif(i)){
                        atual[j] = yytext[i];
                        j++; i++;
                    }
                    atual[j]='\0';

                    pontAtual = (char*) malloc(yyleng*sizeof(char));
                    while(pontuacaoIgual(i)){
                       pontAtual[ocup] = yytext[i];
                       i++; ocup++;
                    }
                    pontAtual[ocup]='\0';
                    
                    copia = (char*) malloc(strlen(atual) * sizeof(char));
                    strcpy(copia,atual);
                    //printf("ATUAL %s, EXISTE %d\n", atual, exists(dicionario,copia));

                    if(exists(dicionario,copia)) {
                        if(antiga!=NULL) {
                            printf("%s", antiga);
                            printf("%s", pontAnt);
                            antiga=NULL;
                            pontAnt=NULL;
                        }
                        printf("\\textbf{%s}\\footnote{%s}%s",atual,getIngles(dicionario,copia),pontAtual);
                        existe = 0;
                        aux = (char*) malloc(strlen(getPalavra(dicionario,copia))*sizeof(char));
                        strcpy(aux,getPalavra(dicionario,copia));

                        for(int k=0; k<tamArray && !existe; k++){
                            if(strcmp(existentes[tamArray],aux)==0) existe=1;
                        }
                        if(!existe){                            
                            existentes[tamArray] = (char*) malloc(strlen(aux)*sizeof(char));
                            strcpy(existentes[tamArray],aux);
                            //tamArray++;
                        }
                        free(aux);
                    }
                    else {
                        if(antiga!=NULL){
                            juntas = (char*) malloc((strlen(antiga)+strlen(pontAnt)+strlen(atual))*sizeof(char));
                            strcat(juntas,antiga);
                            strcat(juntas,pontAnt);
                            strcat(juntas,atual);

                            free(copia);
                            copia = (char*) malloc(strlen(juntas) * sizeof(char));
                            strcpy(copia,juntas);

                            if(exists(dicionario,copia)) {
                                antiga=NULL;
                                pontAnt=NULL;
                                printf("\\textbf{%s}\\footnote{%s}%s",juntas,getIngles(dicionario,copia),pontAtual);
                                existe = 0;
                                aux = (char*) malloc(strlen(getPalavra(dicionario,copia))*sizeof(char));
                                strcpy(aux,getPalavra(dicionario,copia));

                                for(int k=0; k<tamArray && !existe; k++){
                                    if(strcmp(existentes[tamArray],aux)==0) existe=1;
                                }
                                if(!existe){
                                    existentes[tamArray] = (char*) malloc(strlen(aux)*sizeof(char));
                                    strcpy(existentes[tamArray],aux);
                                    tamArray++;
                                }
                                free(aux);
                            }
                            else {
                                printf("%s", antiga);
                                printf("%s", pontAnt);
                            }
                        }
                        free(antiga);
                        free(juntas);
                        free(pontAnt);
                       // printf("antiga %s\n", antiga);
                        antiga = (char*) malloc(strlen(atual)*sizeof(char));

                        //printf("pontAnt %s\n", pontAnt);
                        pontAnt = (char*) malloc(strlen(pontAtual)*sizeof(char));
                        if(atual!=NULL) strcpy(antiga,atual);
                        if(pontAtual!=NULL) strcpy(pontAnt,pontAtual);
                    }
                }
                if(!exists(dicionario,copia)) {
                    printf("%s", atual);
                    printf("%s", pontAtual);
                }
            }
%%

void lexTexto(Dic dic, char* filename){
    dicionario = dic;
    existentes = (char**) malloc(dicionario.ocup*sizeof(char*));
    antiga=NULL;
    pontAnt=NULL;
    atual=NULL;
    pontAtual=NULL;

    textoin = fopen(filename, "r");
    yylex();
}
