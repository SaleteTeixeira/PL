#include "hash.h"
#include "y.tab.h"
#include "lexDicionario.h"
#include "lexTexto.h"

void main(){
    Dic dicionario;
    dicionario = init();
    load(dicionario);
	lexTexto(dicionario);
}
