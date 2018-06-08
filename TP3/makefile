sttc : sttc.o y.tab.o lexDicionario.o lexTexto.o hash.o
	gcc -o sttc sttc.o y.tab.o lexDicionario.o lexTexto.o hash.o -ll -lm

sttc.o : sttc.c lexTexto.o
	gcc -c sttc.c

lexTexto.o : lex.texto.c y.tab.h hash.o
	gcc -c lex.texto.c -o lexTexto.o

lex.texto.c : texto.l hash.o
	flex -l -P texto texto.l

y.tab.o : y.tab.c hash.o
	gcc -c y.tab.c -lm -ll

lexDicionario.o : lex.yy.c y.tab.h hash.o
	gcc -c lex.yy.c -o lexDicionario.o

y.tab.c y.tab.h : dicionario.y hash.o
	yacc -d dicionario.y

lex.yy.c : dicionario.l hash.o
	flex -l dicionario.l

hash.o : hash.c
	gcc -c hash.c -o hash.o

clean:
	rm *.o lex.yy.c lex.texto.c y.tab.c y.tab.h sttc
