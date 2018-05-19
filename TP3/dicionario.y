%{
#include "hash.h"
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

%%

SeqComandos : SeqComandos Comando
            |
            ;

Comando : PALAVRA       {srtcpy(palavra,$1);}           
	    | SIGNIFICADO   {srtcpy(significado,$1);}
	    | Variacoes
        | INGLES        {srtcpy(ingles,$1);}
        | SINONIMOS     {srtcpy(sinonimos,$1); 
                         dicionario = insert(dicionario,palavra,significado,variacoes,ingles,sinonimos);
                         memset(palavra,0,strlen(palavra));
                         memset(significado,0,strlen(significado));
                         for(int i = 0; i < 30; i++){
                            memset(variacoes[i],0,strlen(varicoes[i]));
                         }
                         memset(ingles,0,strlen(ingles));
                         memset(sinonimos,0,strlen(sinominos));
                         v=0;
                         }
        ;

Variacoes : Variacoes ';' Termo
          | Termo
          ;

Termo : '-'
      | VARIACOES {srtcpy(variacoes[v],$1); v++;}
      ;

%%

void load(Dic dic){
    dicionario = dic;    
    yyparse();
}
