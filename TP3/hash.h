typedef struct Estrutura{
    char* palavra;
    char* significado;
    char** variacoes;
    char* ingles;
    char* sinonimos;
    int tam;
    int ocupado;
}Estrutura;

typedef struct Dic{
    int size;
    int ocup;
    Estrutura* e;
}Dic;

Dic init(int size);

int hash(char* palavra, int size);

char* allLower(char* palavra);

void copiar(Dic dic, int pos, char* palavra, char* significado, char* variacoes, char* ingles, char* sinonimos);

Dic insert(Dic ests, char* palavra, char* significado, char* variacoes, char* ingles, char* sinonimos);

void printInfo(Dic dic, char* palavra);

char* getPalavra(Dic dic, char* palavra);

char* getIngles(Dic dic, char* palavra);

int exists(Dic dic, char* palavra);

void clean();
