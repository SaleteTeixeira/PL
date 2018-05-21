#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "hash.h"

char* allLower(char* palavra){
  int tam = strlen(palavra);

  for(int i=0; i<tam; i++){
    putchar(tolower(palavra[i]));
  }

  return palavra;
}

int hash(char* palavra, int size){
  int codigo = 0;
  int tam = strlen(palavra);
  for(int i = 0; i < tam; i++){
    codigo+= (int) palavra[i];
  }

  return codigo%size;
}

char* getIngles(Dic dic, char* palavra){
  int pos = hash(palavra, dic.size);

  if(dic.e[pos].ocupado){
    if(strcmp(allLower(palavra), dic.e[pos].palavra)==0) return dic.e[pos].ingles;
    for(int i=0; i<30; i++){
      if(strcmp(allLower(palavra), dic.e[pos].variacoes[i])==0) return dic.e[pos].ingles;
    }
  }
  int i;
  i = pos+1;
  while(i!=pos){
    if(dic.e[pos].ocupado){
      if(strcmp(allLower(palavra), dic.e[i].palavra)==0) return dic.e[pos].ingles;
      for(int j=0; j<30; j++){
        if(strcmp(allLower(palavra), dic.e[pos].variacoes[j])==0) return dic.e[pos].ingles;
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
    for(int i=0; i<30; i++){
      if(strcmp(allLower(palavra), dic.e[pos].variacoes[i])==0) return 1;
    }
  }
  int i;
  i = pos+1;
  while(i!=pos){
    if(dic.e[pos].ocupado){
      if(strcmp(allLower(palavra), dic.e[i].palavra)==0) return 1;
      for(int j=0; j<30; j++){
        if(strcmp(allLower(palavra), dic.e[i].variacoes[j])==0) return 1;
      }
    }
    i=((i+1)%dic.size);
  }

  return 0;
}

void copiar(Dic dic, int pos, char* palavra, char* significado, char** variacoes, char* ingles, char* sinonimos){
  strcpy(dic.e[pos].palavra, palavra);
  strcpy(dic.e[pos].significado, significado);
  strcpy(dic.e[pos].ingles, ingles);
  strcpy(dic.e[pos].sinonimos, sinonimos);
  dic.e[pos].ocupado=1;
  for(int i = 0; i < 30; i++){
    strcpy(dic.e[pos].variacoes[i],variacoes[i]);
  }
}

Dic insert(Dic ests, char* palavra, char* significado, char** variacoes, char* ingles, char* sinonimos){
  if(((ests.ocup + 1) *2) > ests.size){
    Dic dic;
    dic.size=ests.size*2;
    dic.ocup=ests.ocup+1;
    dic.e = (Estrutura*) malloc(2 * ests.size * sizeof(Estrutura));
    int i;
    for(i=0; i<ests.size; i++){
      dic.e[i].palavra = ests.e[i].palavra;
      dic.e[i].significado = ests.e[i].significado;
      dic.e[i].variacoes = ests.e[i].variacoes;
      dic.e[i].ingles = ests.e[i].ingles;
      dic.e[i].sinonimos = ests.e[i].sinonimos;
      dic.e[i].ocupado = ests.e[i].ocupado;
    }
    int pos = hash(palavra, dic.size);

    if(!dic.e[pos].ocupado){
      if(strcmp(allLower(palavra), dic.e[pos].palavra)!=0){
        copiar(dic,pos,palavra,significado,variacoes,ingles,sinonimos);
      }
    }
    else{
      i = pos+1;
      int flag=0;
      while(i!=pos && !flag){
        if(strcmp(allLower(palavra), dic.e[i].palavra)!=0){
          copiar(dic,i,palavra,significado,variacoes,ingles,sinonimos);
          flag=1;
        }
        i=((i+1)%dic.size);
      }
    }
  }
  else{
    int pos = hash(palavra, ests.size);

    if(!ests.e[pos].ocupado){
      if(strcmp(allLower(palavra), ests.e[pos].palavra)!=0){
        copiar(ests,pos,palavra,significado,variacoes,ingles,sinonimos);
      }
    }
    else{
      int i;
      i = pos+1;
      int flag=0;
      while(i!=pos && !flag){
        if(!ests.e[pos].ocupado){
          if(strcmp(allLower(palavra), ests.e[i].palavra)!=0){
            copiar(ests,i,palavra,significado,variacoes,ingles,sinonimos);
            flag=1;
          }
        }
        i=((i+1)%ests.size);
      }
    }
  }
}

Dic init(){
  Dic dic;
  dic.ocup=0;
  dic.size=40;
  dic.e = (Estrutura*) malloc(40 * sizeof(Estrutura));

  int i;
  for(i=0; i<40; i++){
    dic.e[i].ocupado=0;
  }

  return dic;
}

Dic clean(Dic dic){
  int i;
  for(i=0; i<40; i++){
    free(&dic.e[i]);
  }
  dic.size=0;
  dic.ocup=0;
  return dic;
}
