sttc : sttc.o y.tab.o lexDicionario.yy.o lexTexto.yy.o hash.o
	gcc -o sttc sttc.o y.tab.o lexDicionario.yy.o lexTexto.yy.o hash.o -ll -lm

sttc.o : sttc.c
    gcc -c sttc.c

lexTexto.yy.c : texto.l hash.o
	flex texto.l

y.tab.o : y.tab.c hash.o
	gcc -c y.tab.c

lexDicionario.yy.o : lexDicionario.yy.c y.tab.h hash.o
	gcc -c lexDicionario.yy.c

y.tab.c y.tab.h : dicionario.y hash.o
	yacc -d dicionario.y

lexDicionario.yy.c : dicionario.l hash.o
	flex dicionario.l

hash.o : hash.c
    gcc -c hash.c
