%{
#include "hash.h"
#include <string.h>
extern int yylex();
void yyerror(char*);

int v=0;

char* palavra;
char* significado;
char* variacoes[30];
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

Comando : PALAVRA       {strcpy(palavra,$1);}           
	    | SIGNIFICADO   {strcpy(significado,$1);}
	    | Variacoes
        | INGLES        {strcpy(ingles,$1);}
        | SINONIMOS     {strcpy(sinonimos,$1); 
                         dicionario = insert(dicionario,palavra,significado,variacoes,ingles,sinonimos);
                         memset(palavra,0,strlen(palavra));
                         memset(significado,0,strlen(significado));
                         for(int i = 0; i < 30; i++){
                            memset(variacoes[i],0,strlen(variacoes[i]));
                         }
                         memset(ingles,0,strlen(ingles));
                         memset(sinonimos,0,strlen(sinonimos));
                         v=0;
                         }
        ;

Variacoes : Variacoes ';' Termo
          | Termo
          ;

Termo : '-'
      | VARIACOES {strcpy(variacoes[v],$1); v++;}
      ;

%%

void load(Dic dic){
    dicionario = dic;    
    yyparse();
}
