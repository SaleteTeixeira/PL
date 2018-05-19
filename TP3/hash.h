typedef struct Estrutura{
    char* palavra;
    char* significado;
    char** variacoes;
    char* ingles;
    char* sinonimos;
    int ocupado;
}Estrutura;

typedef struct Dic{
    int size;
    int ocup;
    Estrutura* e;
}Dic;

Dic init();

Dic clean();

int hash(char* palavra, int size);

char* getIngles(Dic dic, char* palavra);

int exists(char* palavra, Dic dic);

void copiar(Dic dic, int pos, char* palavra, char* significado, char** variacoes, char* ingles, char* sinonimos);

Dic insert(Dic ests, char* palavra, char* significado, char** variacoes, char* ingles, char* sinonimos);