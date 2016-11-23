LEX = flex
YACC = bison -d
CC = gcc

calc: calc.c calc.tab.c lex.yy.c
        $(CC) -o calc calc.tab.c lex.yy.c calc.c

calc.tab.c: calc.y
        $(YACC) calc.y

lex.yy.c: calc.l
        $(LEX) calc.l
