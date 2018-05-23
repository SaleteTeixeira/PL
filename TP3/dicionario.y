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
char** variacoes;
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
	    | Variacoes
        | INGLES        { ingles = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(ingles,$1);}
        | SINONIMOS     { sinonimos = (char*) malloc(strlen($1)*sizeof(char));
                          strcpy(sinonimos,$1);
                          printf("Adicionar: %s, %s, %s, %s, %s.",palavra,significado,variacoes,ingles,sinonimos);
                          //dicionario = insert(dicionario,palavra,significado,variacoes,ingles,sinonimos);
                          memset(palavra,0,strlen(palavra));
                          memset(significado,0,strlen(significado));
                          /*for(int i = 0; i < 30; i++){
                             memset(variacoes[i],0,strlen(variacoes[i]));
                          }
                          memset(ingles,0,strlen(ingles));
                          memset(sinonimos,0,strlen(sinonimos));*/
                          v=0;
                        }
        ;

Variacoes : Variacoes ';' Termo
          | Termo
          ;

Termo : '-'
      | VARIACOES { variacoes[v] = (char*) malloc(strlen($1)*sizeof(char));
                    strcpy(variacoes[v],$1); v++;}
      ;

%%

void yyerror (char* erro) {
   fprintf(stderr, "%s\n", erro);
 }

void load(Dic dic, char* filename){
    variacoes = (char**) malloc(30*sizeof(char*));
    dicionario = dic;
   // yyin = stdin;
    yyin = fopen(filename, "r");
    yyparse();
}
