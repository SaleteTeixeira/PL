%{
#include "hash.h"
#include <string.h>
#include <stdio.h>

extern int yylex();
void yyerror(char*);
extern FILE* yyin;

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
                          strcpy(palavra,$1);}           
	    | SIGNIFICADO   { significado = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(significado,$1);}
	    | VARIACOES     { variacoes = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(variacoes,$1);}     
        | INGLES        { ingles = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(ingles,$1);}
        | SINONIMOS     { sinonimos = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(sinonimos,$1);
                          dicionario = insert(dicionario,palavra,significado,variacoes,ingles,sinonimos);
                        }
        ;

%%

void yyerror (char* erro) {
   fprintf(stderr, "%s\n", erro);
}

Dic load(Dic dic, char* filename){
    dicionario = dic;
    yyin = fopen(filename, "r");
    yyparse();
    return dicionario;
}
