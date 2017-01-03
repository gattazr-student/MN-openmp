
    /* test des 3 fonctions (tests complets => test des limites) */
    /* retourne 0 si tout s'est bien passé */
    /* retourn 1 si il y a eu une erreur */
    /* écrit un message d'erreur dans stderr si il y a eu une erreur */
    /* fprintf(stderr, "format", var); */

#include <stdio.h>
#include <vecteur.h>
#include <vects.h>

#define TRUE 1
#define FALSE 0

t_sdVect V1, V2, V3;

int verifie_valeur (t_sdVect vect, double valeur) {
	int i;
	int erreur = FALSE;
	i=0;
	while ((i<SMALLN)&&(!erreur)) {
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
	double valeur1;
	double valeur2;
	double valeur3;
	double scalaire;

    /* On commence par vouloir tester les fonctions de lecture et d'écriture d'un vecteur */
    /* - void read_sdVect(t_sdVect aVect); */
    /* - void write_sdVect(t_sdVect aVect); */

	/* On récupère la veleur que contient chaque composante du vecteur */
	if(scanf("%lf",&valeur1) != 1){
		fprintf(stderr, "autre erreur[1]\n");
	}
	read_sdVect(V1);
	if (verifie_valeur(V1,valeur1)) {
		return 1;
	}
	write_sdVect(V1);
	/* On testera cette procédure dans le shell avec un diff pour voir si la lecture et l'écriture marche bien */

	/* On veut maintenant voir si les opérations sur les vecteurs sont correctes, nous allons pour cela faire des tests simples ider d'un script shell */
	/* - void add_sdVect(t_sdVect aVect1, t_sdVect aVect2, t_sdVect aVect3); */
	/* - void mScalaire_sdVect(t_sdVect aVect1, double aScalaire, t_sdVect aVect2); */
	/* - double pScalaire_sdVect(t_sdVect aVect1, t_sdVect aVect2); */

	if(scanf("%lf",&valeur2) != 1){
		fprintf(stderr, "autre erreur[2]\n");
		return 1;
	}
	read_sdVect(V2);
	valeur3 = valeur1 + valeur2;
	add_sdVect(V1,V2,V3);
	if (verifie_valeur(V3,valeur3)) {
		return 1;
	}

	if(scanf("%lf",&scalaire) != 1){
		fprintf(stderr, "autre erreur[3]\n");
		return 1;
	}
	valeur3 = valeur1 * scalaire;
	mScalaire_sdVect(V1,scalaire,V3);
	if (verifie_valeur(V3,valeur3)) {
		return 1;
	}

	scalaire = pScalaire_sdVect(V1,V2);
	if (scalaire != (SMALLN*(valeur1*valeur2))) { /* on peut faire ceci car le vecteur de test ne contient que les mêmes valeurs */
		fprintf(stderr, "Erreur lors du produit scalaire");
		return 1;
	}

	return 0;
}
