#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <assert.h>
#include "hash.h"

Dic init(int size){
  Dic* dic = malloc(sizeof(Dic));
  dic->ocup=0;
  dic->size=size;
  dic->e = (Estrutura*) malloc(size * sizeof(Estrutura));

  for(int i=0; i<size; i++){
    Estrutura* e = (Estrutura*) malloc(sizeof(Estrutura));
    e->ocupado=0;
    e->tam=0;
    dic->e[i] = *e;
  }

  return *dic;
}

int hash(char* palavra, int size){
  int codigo = 0;
  int tam = strlen(palavra);
  for(int i = 0; i < tam; i++){
    codigo+= (int) palavra[i];
  }

  return codigo%size;
}

char* allLower(char* palavra){
  int tam = strlen(palavra);

  for(int i=0; i<tam; i++){
    palavra[i] = tolower(palavra[i]);
  }

  return palavra;
}

void copiar(Dic dic, int pos, char* palavra, char* significado, char* variacoes, char* ingles, char* sinonimos){
    dic.e[pos].palavra = (char*) malloc(strlen(palavra)*sizeof(char));
    strcpy(dic.e[pos].palavra, palavra);
    
    dic.e[pos].significado = (char*) malloc(strlen(significado)*sizeof(char));
    strcpy(dic.e[pos].significado, significado);

    dic.e[pos].ingles = (char*) malloc(strlen(ingles)*sizeof(char));
    strcpy(dic.e[pos].ingles, ingles);

    dic.e[pos].sinonimos = (char*) malloc(strlen(sinonimos)*sizeof(char));
    strcpy(dic.e[pos].sinonimos, sinonimos);

    dic.e[pos].ocupado=1;

  	char** result    = 0;
    size_t count     = 0;
    char* tmp        = variacoes;
    char* last_comma = 0;
    char delim[2];
    char a_delim = ';';
    delim[0] = ';';
    delim[1] = 0;

    /* Count how many elements will be extracted. */
    while (*tmp)
    {
        if (a_delim == *tmp)
        {
            count++;
            last_comma = tmp;
        }
        tmp++;
    }

    int tamanho = count+1;

    /* Add space for trailing token. */
    count += last_comma < (variacoes + strlen(variacoes) - 1);
    /* Add space for terminating null string so caller
       knows where the list of returned strings ends. */
    count++;

    result = malloc(sizeof(char*) * count);

    if (result) {
        size_t idx  = 0;
        char* token = strtok(variacoes, delim);

        while (token)
        {
            assert(idx < count);
            *(result + idx++) = strdup(token);
            token = strtok(0, delim);
        }
        assert(idx == count - 1);
        *(result + idx) = 0;
    }

   dic.e[pos].tam=tamanho;
   dic.e[pos].variacoes = (char**) malloc(tamanho*sizeof(char*));

   for(int i = 0; i < dic.e[pos].tam; i++){
        dic.e[pos].variacoes[i] = (char*) malloc(strlen(result[i])*sizeof(char));
        if(i!=0) strcpy(dic.e[pos].variacoes[i],result[i]+1);
        else strcpy(dic.e[pos].variacoes[i],result[i]);
   }
}





Dic insert(Dic ests, char* palavra, char* significado, char* variacoes, char* ingles, char* sinonimos){

  if(((ests.ocup + 1) *2) > ests.size){
    Dic dic = init(ests.size*2);
    dic.ocup=ests.ocup;
    for(int i=0; i<ests.size; i++){
      if(ests.e[i].ocupado){
          dic.e[i].ocupado = ests.e[i].ocupado;
          dic.e[i].tam = ests.e[i].tam;

          dic.e[i].palavra = (char*) malloc(strlen(ests.e[i].palavra)*sizeof(char));
          strcpy(dic.e[i].palavra,ests.e[i].palavra);

          dic.e[i].significado = (char*) malloc(strlen(ests.e[i].significado)*sizeof(char));
          strcpy(dic.e[i].significado,ests.e[i].significado);

          dic.e[i].variacoes = (char**) malloc(dic.e[i].tam*sizeof(char*));
          for(int k=0; k<dic.e[i].tam; k++){
              dic.e[i].variacoes[k] = (char*) malloc(strlen(ests.e[i].variacoes[k])*sizeof(char));
              strcpy(dic.e[i].variacoes[k],ests.e[i].variacoes[k]);
          }

          dic.e[i].ingles = (char*) malloc(strlen(ests.e[i].ingles)*sizeof(char));
          strcpy(dic.e[i].ingles,ests.e[i].ingles);

          dic.e[i].sinonimos = (char*) malloc(strlen(ests.e[i].sinonimos)*sizeof(char));
          strcpy(dic.e[i].sinonimos,ests.e[i].sinonimos);
      }
    }
    clean(ests);

    int pos = hash(palavra, dic.size);

    if(!dic.e[pos].ocupado){
        copiar(dic,pos,palavra,significado,variacoes,ingles,sinonimos);
        dic.ocup++;
    }
    else{
      int flag=0;
      for(int i=0; i<dic.size && !flag; i++){
          if(!dic.e[i].ocupado) {
            copiar(dic, i, palavra, significado, variacoes, ingles, sinonimos);
            flag = 1;
            dic.ocup++;
          }
      }
    }

    return dic;
  }
  else{
    int pos = hash(palavra, ests.size);

    if(!ests.e[pos].ocupado){
        copiar(ests,pos,palavra,significado,variacoes,ingles,sinonimos);
        ests.ocup++;
    }
    else{
        int flag=0;
        for(int i=0; i<ests.size && !flag; i++){
            if(!ests.e[i].ocupado) {
                copiar(ests, i, palavra, significado, variacoes, ingles, sinonimos);
                flag = 1;
                ests.ocup++;
            }
        }
    }

    return ests;
  }
}


//METER MAIS BONITO ---------------------------------> SÉRGIO
void printInfo(Dic dic, char* palavra){
  int pos = hash(palavra, dic.size);

  if(dic.e[pos].ocupado && strcmp(dic.e[pos].palavra,allLower(palavra))==0){
      printf("%s & %s & ", dic.e[pos].palavra, dic.e[pos].significado);
      for(int i=0; i<dic.e[pos].tam; i++){
        printf("%s; ",dic.e[pos].variacoes[i]);
      }
      printf(" & %s & %s\\\\\n", dic.e[pos].ingles, dic.e[pos].sinonimos);
  }
  else{
      int flag=0;
      for(int i=0; i<dic.size && !flag; i++){
          if(dic.e[i].ocupado && strcmp(dic.e[i].palavra,allLower(palavra))==0){
              printf("%s & %s & ", dic.e[i].palavra, dic.e[i].significado);
              for(int i=0; i<dic.e[i].tam; i++){
                  printf("%s; ",dic.e[i].variacoes[i]);
              }
              printf(" & %s & %s\\\\\n", dic.e[i].ingles, dic.e[i].sinonimos);
          }
      }
  }
}


















//POR TESTAR //

char* getPalavra(Dic dic, char* palavra){
  int pos = hash(palavra, dic.size);

  if(dic.e[pos].ocupado){
    if(strcmp(allLower(palavra), dic.e[pos].palavra)==0) return dic.e[pos].palavra;
    for(int i=0; i<dic.e[pos].tam; i++){
      if(strcmp(allLower(palavra), dic.e[pos].variacoes[i])==0) return dic.e[pos].palavra;
    }
  }
  int i;
  i = pos+1;
  while(i!=pos){
    if(dic.e[i].ocupado){
      if(strcmp(allLower(palavra), dic.e[i].palavra)==0) return dic.e[pos].palavra;
      for(int j=0; j<dic.e[i].tam; j++){
        if(strcmp(allLower(palavra), dic.e[i].variacoes[j])==0) return dic.e[pos].palavra;
      }
    }
    i=((i+1)%dic.size);
  }

  return NULL;
}

char* getIngles(Dic dic, char* palavra){
  int pos = hash(palavra, dic.size);

  if(dic.e[pos].ocupado){
    if(strcmp(allLower(palavra), dic.e[pos].palavra)==0) return dic.e[pos].ingles;
    for(int i=0; i<dic.e[pos].tam; i++){
      if(strcmp(allLower(palavra), dic.e[pos].variacoes[i])==0) return dic.e[pos].ingles;
    }
  }
  int i;
  i = pos+1;
  while(i!=pos){
    if(dic.e[i].ocupado){
      if(strcmp(allLower(palavra), dic.e[i].palavra)==0) return dic.e[pos].ingles;
      for(int j=0; j<dic.e[i].tam; j++){
        if(strcmp(allLower(palavra), dic.e[i].variacoes[j])==0) return dic.e[pos].ingles;
      }
    }
    i=((i+1)%dic.size);
  }

  return NULL;
}

int exists(Dic dic, char* palavra){
  int pos = hash(palavra, dic.size);

  if(dic.e[pos].ocupado){
    if(strcmp(allLower(palavra), dic.e[pos].palavra)==0) return 1;
    for(int i=0; i<dic.e[pos].tam; i++){
      if(strcmp(allLower(palavra), dic.e[pos].variacoes[i])==0) return 1;
    }
  }
  int i;
  i = pos+1;
  while(i!=pos){
    if(dic.e[i].ocupado){
      if(strcmp(allLower(palavra), dic.e[i].palavra)==0) return 1;
      for(int j=0; j<dic.e[i].tam; j++){
        if(strcmp(allLower(palavra), dic.e[i].variacoes[j])==0) return 1;
      }
    }
    i=((i+1)%dic.size);
  }

  return 0;
}




//FREE NÃO FUNCIONA, NEM OS DO YACC ---------------------------------------------------> SÉRGIO
void clean(Dic dic){
  for(int i=0; i<dic.size; i++){
    if(dic.e[i].ocupado){
        /*free(&dic.e[i].palavra);
        free(&dic.e[i].sinonimos);
        free(&dic.e[i].significado);
        free(&dic.e[i].ingles);
        for(int k=0; k<dic.e[i].tam; k++){
            free(&dic.e[i].variacoes[k]);
        }
        free(&dic.e[i].variacoes);*/
    }
    //free(&dic.e[i]);
  }
  dic.size=0;
  dic.ocup=0;
  //free(&dic.e);
  //free(&dic);
}