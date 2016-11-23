/* fichier tp-calc.l */
/* compilation: flex tp-calc.l */
/* resultat: lex.yy.c = code en C de l'analyseur lexical */

%{
	/* fichier dans lequel est defini la macro constante NOMBRE */
	#include "tp-calc.tab.h"
	#include <stdio.h>

	#define DEBUG 0
	void printDetect(char * desc) { if(DEBUG) {printf("Détécté : %s\n", desc);} }

%}

lettre [a-zA-Z]
chiffre [0-9]
alphanum {lettre}|{chiffre}

%%

create|CREATE {printDetect("Create"); return CREATE;}
table|TABLE {printDetect("Table"); return TABLE;}
date|DATE {printDetect("Date Type"); return DATE;}
number|NUMBER {printDetect("Number Type"); return NUMBER;}
varchar|VARCHAR {printDetect("Varchar Type"); return VARCHAR;}
varchar2|VARCHAR2 {printDetect("Varchar 2 Type"); return VARCHAR2;}
constraint|CONSTRAINT {printDetect("Constraint"); return CONSTRAINT;}
references|REFERENCES {printDetect("References"); return REFERENCES;}
foreign|FOREIGN {printDetect("Foreign"); return FOREIGN;}
primary|PRIMARY {printDetect("Primary"); return PRIMARY;}
key|KEY {printDetect("Key"); return KEY;}
type|TYPE {printDetect("Type"); return TYPE;}
as|AS {printDetect("As");return AS;}
object|OBJECT {printDetect("Object"); return OBJECT;}
of|OF {printDetect("Of");return OF;}
select|SELECT {printDetect("Select"); return SELECT;}
from|FROM {printDetect("From"); return FROM;}
{chiffre}* {return INTEGER;}
{lettre}{alphanum}* {printDetect("Nom de table");yylval.sval=strdup(yytext);return ELEMENT_NAME;}

[ \t] 	; /* ignore les blancs et tabulations */
\n		return 0;
.		return yytext[0];
%%
