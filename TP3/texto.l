%x verb

%{
#include "hash.h"
char* copia;
char* atual = NULL;
char* antiga = NULL;
char* juntas = NULL;
char* pontAnt = NULL;
char* pontAtual = NULL;
char** existentes;
char* aux;
int i=0, j, ocup, tamArray=0, existe, juntou=0;
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

void naoexiste(){
    existentes[tamArray] = (char*) malloc(strlen(aux)*sizeof(char));
	strcpy(existentes[tamArray],aux);
	tamArray++;
}

void iniciar(){
    free(atual);
	free(pontAtual);
	atual = NULL;
	copia = NULL;
	pontAtual = NULL;

	j = 0;
	ocup = 0;
	juntou = 0;

	atual = (char*) malloc(yyleng*sizeof(char));
	while(pontuacaoDif(i)){
		atual[j] = yytext[i];
		j++; i++;
	}
	if(!j) atual=NULL;
	else atual[j] = '\0';

	pontAtual = (char*) malloc(yyleng*sizeof(char));
	while(pontuacaoIgual(i)){
		pontAtual[ocup] = yytext[i];
		i++; ocup++;
	}
	if(!ocup) pontAtual = NULL; 
	else pontAtual[ocup]='\0';
}

void existef(){
    aux = (char*) malloc(strlen(getPalavra(dicionario,copia))*sizeof(char));
	strcpy(aux,getPalavra(dicionario,copia));

	for(int k=0; k<tamArray && !existe; k++){
		if(strcmp(existentes[k],aux)==0) existe=1;
	}
}


%}

%%

^\\begin\{verbatim\}		{ printf("\\begin{verbatim}");
							  BEGIN verb;
							}

<verb>^\\end\{verbatim\} 	{ printf("\\end{verbatim}");
							  BEGIN 0;
							}

<verb>.*					{ printf("%s",yytext);}

^\\begin\{document\}    { printf("\\usepackage[toc,page]{appendix}\n");
						  printf("\\usepackage{array}\n");
						  printf("\\newcolumntype{P}[1]{>{\\hspace{0pt}}p{#1}}\n");
						  printf("\\usepackage{longtable}\n");
						  printf("\\begin{document}");
						}

^\\end\{document\}      { if(tamArray){
							printf("\\clearpage\n");
							printf("\\begin{appendix}\n");
							printf("\\section{Dicionário Cinematográfico}\n");
							printf("\\begingroup\n");
							printf("\\setlength\\LTleft{-90pt}\n");
							printf("\\setlength\\LTright{100pt}\n");
							printf("\\begin{longtable}{|p{0.2\\linewidth}|p{0.5\\linewidth}|p{0.25\\linewidth}|p{0.2\\linewidth}|p{0.15\\linewidth}|}\\hline\n");
							printf("\\textbf{Palavra} & \\textbf{Significado} & \\textbf{Variações}");
							printf(" & \\textbf{Designação em Inglês} & \\textbf{Sinónimos}\\\\\\hline\n");
							for(i=0; i<tamArray; i++){
								printInfo(dicionario,existentes[i]);
							}
							printf("\\caption{Tabela ilustrativa do Dicionário}\n");
							printf("\\end{longtable}\n");
							printf("\\endgroup\n");
							printf("\\end{appendix}\n");
						  }
						  printf("\\end{document}");
                        }

\n 						{printf("\n");}

.*            			{   i=0;
							while(i<yyleng){
			                    iniciar();

			                    if(antiga!=NULL){
			                        juntas = (char*) malloc((strlen(antiga)+strlen(pontAnt)+strlen(atual))*sizeof(char));
			                        strcat(juntas,antiga);
			                        strcat(juntas,pontAnt);
			                        strcat(juntas,atual);

			                        copia = (char*) malloc(strlen(juntas) * sizeof(char));
			                        strcpy(copia,juntas);

			                        if(exists(dicionario,copia)){
			                        	juntou=1;
			                        	free(antiga);
			                        	free(pontAnt);
			                        	antiga=NULL;
			                        	pontAnt=NULL;
			                            existe = 0;
			                            printf("\\textbf{%s}\\footnote{%s}%s",juntas,getIngles(dicionario,copia),pontAtual);

			                            existef();
			                            if(!existe){
			                                naoexiste();
			                            }
			                            free(aux);
			                            free(copia);
			                        }
			                        else{
			                        	free(copia);
			                            copia = (char*) malloc(strlen(antiga) * sizeof(char));
			                            strcpy(copia,antiga);

			                            if(exists(dicionario,copia)){
			                                existe = 0;
			                                printf("\\textbf{%s}\\footnote{%s}%s",antiga,getIngles(dicionario,copia),pontAnt);
			                                existef();
			                                if(!existe){                            
			                                    naoexiste();
			                                }
			                                free(aux);
			                            }
			                            else{
			                            	printf("%s", antiga);
			                            	printf("%s", pontAnt);
			                            }
			                            free(copia);
			                            free(antiga);
				                        //free(pontAnt);
				                        antiga = (char*) malloc(strlen(atual)*sizeof(char));
			                            pontAnt = (char*) malloc(strlen(pontAtual)*sizeof(char));
			                            strcpy(antiga,atual);
			                            strcpy(pontAnt,pontAtual);
			                        }
			                        free(juntas);
			                    }
			                    else{
			                        if(pontAnt!=NULL){
			                            printf("%s", pontAnt);
			                            pontAnt=NULL;
			                        }

			                        free(antiga);
			                        free(pontAnt);
			                       
			                        if(atual != NULL){
			                        	antiga = (char*) malloc(strlen(atual)*sizeof(char));
			                        	strcpy(antiga,atual);
			                        }
			                        else antiga = NULL;

			                        if(pontAtual != NULL){
			                        	pontAnt = (char*) malloc(strlen(pontAtual)*sizeof(char));
										strcpy(pontAnt,pontAtual);
			                        }
			                        else antiga = NULL;
			                    }
			                }
			                if(!juntou) {
			                	copia = (char*) malloc(strlen(atual) * sizeof(char));
	                        	strcpy(copia,atual);

				                if(exists(dicionario,copia)){
				                	printf("\\textbf{%s}\\footnote{%s}%s",atual,getIngles(dicionario,copia),pontAtual);
				                	existe=0;
		                            existef();
		                            if(!existe){                            
		                                naoexiste();
		                            }
		                            free(aux);
				                }
				                else{
				                	printf("%s", atual);
				                	printf("%s", pontAtual);
				                }
				                free(copia);
				            }
				            free(antiga);
				            free(pontAnt);
				            antiga=NULL;
				            pontAnt=NULL;
			            }

%%

void lexTexto(Dic dic, char* filename){
    dicionario = dic;
    existentes = (char**) malloc(dicionario.ocup*sizeof(char*));

    textoin = fopen(filename, "r");
    yylex();
}
