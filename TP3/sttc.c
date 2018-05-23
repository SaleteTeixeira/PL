#include "hash.h"
#include "y.tab.h"
#include "lexDicionario.h"
#include "lexTexto.h"
#include <stdio.h>

int main(int argc, char* argv[]){

    if(argc < 3) return -1;

    Dic dicionario;
    dicionario = init();
    load(dicionario, argv[1]);
	/*lexTexto(dicionario, argv[2]);*/

    printf("CONSEGUIR CHEGAR AQUI\n");

    return 0;
}
