
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

t_bdVect V1, V2, V3;

int verifie_valeur (t_bdVect vect, double valeur) {
	int i;
	int erreur = FALSE;
	i=0;

	while ((i<BIGN)&&(!erreur)) {
		if (vect[i]!=valeur) {
			erreur = TRUE;
			fprintf(stderr,"\n\tErreur sur la valeur du vecteur à l'indice %i -> %f != %f.\n\n",i,valeur,vect[i]);
		}
		i++;
	}
	return erreur;
}

int main(void)
{
	double valeur1;
	double valeur2;
	double valeur3;
	double scalaire;

    /* On commence par vouloir tester les fonctions de lecture et d'écriture d'un vecteur */
    /* - void read_bdVect(t_bdVect aVect); */
    /* - void write_bdVect(t_bdVect aVect); */

	/* On récupère la veleur que contient chaque composante du vecteur */
	if(scanf("%lf",&valeur1) != 1){
		fprintf(stderr, "autre erreur[1]\n");
	}
	read_bdVect(V1);
	if (verifie_valeur(V1,valeur1)) {
		fprintf(stderr, "lecture incorrecte\n");
		return 1;
	}
	write_bdVect(V1);
	/* On testera cette procédure dans le shell avec un diff pour voir si la lecture et l'écriture marche bien */

	/* On veut maintenant voir si les opérations sur les vecteurs sont correctes, nous allons pour cela faire des tests simples ider d'un script shell */
	/* - void add_bdVect(t_bdVect aVect1, t_bdVect aVect2, t_bdVect aVect3); */
	/* - void mScalaire_bdVect(t_bdVect aVect1, double aScalaire, t_bdVect aVect2); */
	/* - double pScalaire_bdVect(t_bdVect aVect1, t_bdVect aVect2); */

	if(scanf("%lf",&valeur2) != 1){
		fprintf(stderr, "autre erreur[2]\n");
		return 1;
	}
	read_bdVect(V2);
	valeur3 = valeur1 + valeur2;
	add_bdVect(V1,V2,V3);
	if (verifie_valeur(V3,valeur3)) {
		fprintf(stderr, "addition incorrecte\n");
		return 1;
	}

	if(scanf("%lf",&scalaire) != 1){
		fprintf(stderr, "autre erreur[3]\n");
		return 1;
	}
	valeur3 = valeur1 * scalaire;
	mScalaire_bdVect(V1,scalaire,V3);
	if (verifie_valeur(V3,valeur3)) {
		fprintf(stderr, "multiplication incorrecte\n");
		return 1;
	}

	scalaire = pScalaire_bdVect(V1,V2);
	if (scalaire != (BIGN*(valeur1*valeur2))) { /* on peut faire ceci car le vecteur de test ne contient que les mêmes valeurs */
		fprintf(stderr, "Erreur lors du produit scalaire\n");
		return 1;
	}

	return 0;
}
