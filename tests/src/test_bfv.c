
    /* test des 3 fonctions (tests complets => test des limites) */
    /* retourne 0 si tout s'est bien passé */
    /* retourn 1 si il y a eu une erreur */
    /* écrit un message d'erreur dans stderr si il y a eu une erreur */
    /* fprintf(stderr, "format", var); */

#include <stdio.h>
#include <vecteur.h>
#include <vectb.h>

#define TRUE 1
#define FALSE 0

t_bfVect V1, V2, V3;

int verifie_valeur (t_bfVect vect, float valeur) {
	int i;
	int erreur = FALSE;
	i=0;

	while ((i<BIGN)&&(!erreur)) {
		if (vect[i]!=valeur) {
			erreur = TRUE;
			fprintf(stderr,"\n\tErreur sur la lecture du vecteur au niveau de la ligne %i -> %f != %f.\n\n",i,valeur,vect[i]);
		}
		i++;
	}
	return erreur;
}

int main(void)
{
	float valeur1;
	float valeur2;
	float valeur3;
	float scalaire;

    /* On commence par vouloir tester les fonctions de lecture et d'écriture d'un vecteur */
    /* - void read_bfVect(t_bfVect aVect); */
    /* - void write_bfVect(t_bfVect aVect); */

	/* On récupère la veleur que contient chaque composante du vecteur */
	if(scanf("%f",&valeur1) != 1){
		fprintf(stderr, "autre erreur[1]\n");
	}
	read_bfVect(V1);
	if (verifie_valeur(V1,valeur1)) {
		return 1;
	}
	write_bfVect(V1);
	/* On testera cette procédure dans le shell avec un diff pour voir si la lecture et l'écriture marche bien */

	/* On veut maintenant voir si les opérations sur les vecteurs sont correctes, nous allons pour cela faire des tests simples ider d'un script shell */
	/* - void add_bfVect(t_bfVect aVect1, t_bfVect aVect2, t_bfVect aVect3); */
	/* - void mScalaire_bfVect(t_bfVect aVect1, float aScalaire, t_bfVect aVect2); */
	/* - float pScalaire_bfVect(t_bfVect aVect1, t_bfVect aVect2); */

	if(scanf("%f",&valeur2) != 1){
		fprintf(stderr, "autre erreur[2]\n");
		return 1;
	}
	read_bfVect(V2);
	valeur3 = valeur1 + valeur2;
	add_bfVect(V1,V2,V3);
	if (verifie_valeur(V3,valeur3)) {
		return 1;
	}

	if(scanf("%f",&scalaire) != 1){
		fprintf(stderr, "autre erreur[3]\n");
		return 1;
	}
	valeur3 = valeur1 * scalaire;
	mScalaire_bfVect(V1,scalaire,V3);
	if (verifie_valeur(V3,valeur3)) {
		return 1;
	}

	scalaire = pScalaire_bfVect(V1,V2);
	if (scalaire != (BIGN*(valeur1*valeur2))) { /* on peut faire ceci car le vecteur de test ne contient que les mêmes valeurs */
		fprintf(stderr, "Erreur lors du produit scalaire");
		return 1;
	}

	return 0;
}
