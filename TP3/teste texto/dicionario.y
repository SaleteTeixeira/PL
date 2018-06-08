%{
#include "hash.h"
#include <string.h>
#include <stdio.h>

extern int yylex();
void yyerror(char*);
extern FILE* yyin;

int v=0;

char* palavra;
char* significado;
char* variacoes;
char* ingles;
char* sinonimos;
Dic dicionario;
%}

%token PALAVRA SIGNIFICADO VARIACOES INGLES SINONIMOS

%union{
    char* text;
}

%type <text> PALAVRA SIGNIFICADO VARIACOES INGLES SINONIMOS

%%

SeqComandos : SeqComandos Comando
            |
            ;

Comando : PALAVRA       { palavra = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(palavra,$1);
printf("Y. Palavra: %s\n", palavra);}           
	    | SIGNIFICADO   { significado = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(significado,$1);
printf("Y. Sig: %s\n", significado);}
	    | VARIACOES     { variacoes = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(variacoes,$1);
printf("Y. Variacoes: %s\n", variacoes);}     
        | INGLES        { ingles = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(ingles,$1);
printf("Y. Ing: %s\n", ingles);}
        | SINONIMOS     { sinonimos = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(sinonimos,$1);
printf("Y. Sinonimos: %s\n", sinonimos);
                          printf("Y. Adicionar: %s, %s, %s, %s, %s.\n\n",palavra,significado,variacoes,ingles,sinonimos);
                          dicionario = insert(dicionario,palavra,significado,variacoes,ingles,sinonimos);
                          memset(palavra,0,strlen(palavra));
                          memset(significado,0,strlen(significado));
                          memset(variacoes,0,strlen(variacoes));
                          memset(ingles,0,strlen(ingles));
                          memset(sinonimos,0,strlen(sinonimos));
                          v=0;
                        }
        ;

%%

void yyerror (char* erro) {
   fprintf(stderr, "%s\n", erro);
}

void load(Dic dic, char* filename){
    dicionario = dic;
    yyin = fopen(filename, "r");
    yyparse();
}
