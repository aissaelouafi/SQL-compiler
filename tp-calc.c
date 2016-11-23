/* fichier tp-calc.c */
/* compilation: gcc -o tp-calc.out tp-calc.c tp-calc.tab.c lex.yy.c */
/* resultat: tp-calc.out = executable permettant d’analyser des expressions arithm ́etiques */

#include <stdio.h>

int main(void) {
	if(yyparse() == 0) {
			// Affichage des resultats des actions semantiques menees sur les documents
	    printf("\nAnalyse réussie\n");
	}
}
