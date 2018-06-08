sttc : sttc.o y.tab.o lexDicionario.o hash.o
	gcc -o sttc sttc.o y.tab.o lexDicionario.o hash.o -ll -lm

sttc.o : sttc.c y.tab.o lexDicionario.o hash.o
	gcc -c sttc.c

lexDicionario : y.tab.o lexDicionario.o hash.o
	gcc -o lexDicionario y.tab.o lexDicionario.o -ll -lm

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
