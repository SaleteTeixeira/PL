#include "hash.h"
#include "y.tab.h"
#include "lexDicionario.yy.h"
#include "lexTexto.yy.h"

void main(){
    Dic dicionario;
    dicionario = init();
    load(dicionario);
	lexTexto(dicionario);
}
