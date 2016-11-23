#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct {
	char *identif; // table name and column name
	int type; //if table or column (0 to table or 1 to column)
	char* complement; // in the case of column we define her the table name of this column
} ENTREE_DICO;


#define TAILLE_INITIALE_DICO 250
// Type dico :
#define T_TABLE 0
#define T_COLUMN 1


//variables globales
ENTREE_DICO *dico;
int maxDico, sommet, base;

void creerDico(void) {
	maxDico = TAILLE_INITIALE_DICO;
	dico = malloc(maxDico * sizeof(ENTREE_DICO));
	if (dico == NULL)
		erreurFatale("Erreur interne (pas assez de memoire)");
	sommet = 0;
	base = 0;
}

int erreurFatale(char *message) {
	fprintf(stderr, "%s\n", message);
	exit(-1);
}

void ajouterEntree(char *identif, int type, char *complement) {
  dico[sommet].identif = malloc(strlen(identif) + 1);
  dico[sommet].complement = malloc(strlen(complement) + 1);
  if (dico[sommet].identif == NULL)
    erreurFatale("Erreur interne (pas assez de m ́emoire)");
	strcpy(dico[sommet].identif, identif);
	dico[sommet].type = type;
	strcpy(dico[sommet].complement, complement);
  sommet++;
}

void afficheDico(void) {
	int i;
	char* type;

	printf("\n--- SELECT Dico Content : ---\n\n");
	for(i=base;i<sommet;i++) {
		switch(dico[i].type) {
			case 0: type = "T_TABLEAU";break;
			case 1: type = "T_COLUMN";break;
		}
		printf("Entrée : %s (%s, %s)\n", dico[i].identif, type, dico[i].complement);
	}
	printf("\n------------------------------\n\n");
}


/*
// Define column struct
struct column {
  char *name; // Column name
  char *type; // Column type (date, integer, string ...)
};

// Define constrant struct
struct constraint {
  int type; // 0 to primary key and 1 to foreign key
  char *name; // Constraint name
  char * columns_references[]; // References column (foreign key case)
};


// Define object struct (object to translate to SQL2 syntax)
struct object {
	char *table_name;
  struct column columns[];
  struct constraint CONSTRAINT[];
};
*/

void documentLanguage(int indice){
  if(indice == 2){
    printf("Document contient uniquement SQL 2 \n");
  } else if (indice == 3){
    printf("Document contient uniquement SQL 3 \n");
  }
}

void sql3ToSql2(){
  printf("SQL 3 to SQL 2 traductor \n");
}
