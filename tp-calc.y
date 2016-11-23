/* fichier tp-calc.y */
/* compilation: bison -d tp-calc.y */
/* resultat: tp-calc.tab.c = code en C de l'analyseur */
/* resultat: tp-calc.tab.h = def des codes des utnités lexicales */

%{
#include <stdlib.h>
#include <string.h>

#include "SQL.c"

%}

/* liste des terminaux */
%union {double dval; int ival; char* sval;}
%token CREATE
%token TABLE
%token <sval> ELEMENT_NAME
%token DATE
%token NUMBER
%token VARCHAR
%token VARCHAR2
%token CONSTRAINT
%token REFERENCES
%token INTEGER
%token FOREIGN
%token PRIMARY
%token KEY
%token OBJECT
%token AS
%token TYPE
%token OF
%token SELECT
%token FROM
%%

// Exemple a executer (SQL2) : CREATE TABLE test(id NUMBER, CONSTRAINT contraintTest PRIMARY KEY (id))

// Programme SQL 2


//programmeSQL (inclus SQL2 and SQL3)
programmeSQL : {creerDico();} queries {afficheDico();};

queries : createTableSQL2 {documentLanguage(2);}
            | createObject createTableSQL3 {documentLanguage(3);}
            | selectQuery {documentLanguage(2);}
            ;

// Select Query
selectQuery : SELECT columnsToSelect FROM argumentDeclarations ';'; // garder l'indice et corriger le dico 

// Create table SQL2
createTableSQL2 : CREATE TABLE ELEMENT_NAME '(' instructions ')';

// Create type SQL3
createObject : CREATE TYPE ELEMENT_NAME TYPE AS OBJECT '(' columnDeclarationsSQL3 ')';

// Create table SQL3
createTableSQL3 : CREATE TABLE ELEMENT_NAME OF ELEMENT_NAME '(' constraintDeclarations ')';

// instructions
instructions : columnDeclarations constraintDeclarations;

// La declarations des colonnes
columnDeclaration : ELEMENT_NAME dataType;

// La declarations dune liste de colonnes
columnDeclarations : columnDeclaration columnDeclarationFacto;

// La delcarations de colonnes factorises
columnDeclarationFacto : ',' columnDeclaration columnDeclarationFacto
            | ','
            ;

// Column Declaration in SQL3 without last coma ! no constraint before the columns declaration
columnDeclarationsSQL3 : columnDeclaration columnDeclarationSQL3Facto;

columnDeclarationSQL3Facto : ',' columnDeclaration columnDeclarationSQL3Facto
            | // vide
            ;


// Column Declaration of SELECT Query
columnsToSelect : ELEMENT_NAME columnToSelectFacto {ajouterEntree($1,T_COLUMN,"a");};
            | // vide
            ;

columnToSelectFacto : ',' ELEMENT_NAME columnToSelectFacto {ajouterEntree($2,T_COLUMN,"a");}
            | // vide
            ;



// La declarations des arguments
argumentDeclaration : ELEMENT_NAME;

// La declaration dune liste darguments
argumentDeclarations : argumentDeclaration argumentDeclarationFacto;

argumentDeclarationFacto : ',' argumentDeclaration argumentDeclarationFacto
          | // vide
          ;

// Exemple a executer : CREATE TABLE test(id NUMBER, CONSTRAINT contraintTest PRIMARY KEY (id))

// Declaration de la constrainte dune cle primaire
primaryKeyConstraintDeclaration : CONSTRAINT ELEMENT_NAME PRIMARY KEY '(' argumentDeclarations ')';

// Declaration de la contrainte dune cle etrangere
foreignKeyConstraintDeclaration : CONSTRAINT ELEMENT_NAME FOREIGN KEY '(' argumentDeclarations ')' REFERENCES ELEMENT_NAME '(' argumentDeclarations ')';

// Liste de declaration dune seule contrainte
constraintDeclaration : primaryKeyConstraintDeclaration
          | foreignKeyConstraintDeclaration
          ;

// Liste de declaration dune liste de constraintes
constraintDeclarations : constraintDeclaration constraintDeclarationFacto;

constraintDeclarationFacto : ',' constraintDeclaration constraintDeclarationFacto
        | // vide
        ;


// La declaration des types (sans la possibilite de definir la taille du type dans une premiere version)
dataType : DATE
         | NUMBER
         | VARCHAR
         | VARCHAR2
         ;

%%

#include <stdio.h>

int yyerror(void) {
	fprintf(stderr, "erreur de syntaxe\n");
	return 1;
}

int yywrap(void) {
    return 1;
}
