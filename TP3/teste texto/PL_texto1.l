%{
char* atual=NULL;
char* antiga=NULL;
char* juntas=NULL;
char* pontAnt;
char* pontAtual;
char** existentes;
char* aux;
int i, j, ocup, tamArray=0, existe;
char* array[6] = {"ator","cenário","duplo","curta-metragem","cenário","efeitos visuais"};

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

\\end\{document\}     { printf("\\begin{appendices}\n");
                        printf("\\chapter{Dicionário Cinematográfico}\n");
                        printf("\\begin{table}[h!]\n");
                        printf("\\begin{center]\n");
                        printf("\\begin{tabular}{c|c|c|c|c}\n");
                        printf("\\textbf{Palavra} & \\textbf{Significado} & \\textbf{Variações}");
                        printf(" & \\textbf{Designação em Inglês} & \\textbf{Sinónimos}\\\n");
                        printf("\\hline\n");
                        for(i=0; i<tamArray; i++){
                            for(int p=0;p<6;p++){
                                if(strcmp(existentes[i],array[p])==0) printf("%s",array[p]);
                            }
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

            int existeARRAY=0;
            for(i=0; i<tamArray; i++){
                for(int p=0;p<6;p++){
                    if(strcmp(existentes[i],array[p])==0) existeARRAY=1;
                }
            }
                    
                    if(existeARRAY) {
                        printf("\\textbf{%s}\\footnote{%s}",atual,"ingles");
                        existe = 0;
                        strcpy(aux,atual);
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
                            strcat(juntas,antiga);
                            strcat(juntas,pontAnt);
                            strcat(juntas,atual);

                            int existeARRAY=0;
                            for(i=0; i<tamArray; i++){
                                for(int p=0;p<6;p++){
                                    if(strcmp(existentes[i],array[p])==0) existeARRAY=1;
                                }
                            }

                            if(existeARRAY) {
                                printf("\\textbf{%s}\\footnote{%s}",juntas,"Ingles");
                                existe = 0;
                                strcpy(aux,juntas);
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

            int existeARRAY=0;
            for(i=0; i<tamArray; i++){
                for(int p=0;p<6;p++){
                    if(strcmp(existentes[i],array[p])==0) existeARRAY=1;
                }
            }

                if(existeARRAY) printf("%s", atual);
                printf("%s", pontAtual);
            }
%%

int main(){
    yylex();
    return 0;}
