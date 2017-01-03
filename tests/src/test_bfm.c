
    /* TEST de fiabilité */
    /* retourne 0 si tout s'est bien passé */
    /* retourn 1 si il y a eu une erreur */
    /* écrit un message d'erreur dans stderr si il y a eu une erreur */
    /* fprintf(stderr, "format", var); */

#include <stdio.h>
#include <matrice.h>
#include <matrb.h>

t_bfMatr M1, M2, M3;
t_bfMatrVect Vect_x, Vect_r, Vect_y;

int verifie_valeur (t_bfMatr matrice, double valeur) {
	int i;
	int j;
	int erreur = 0;
	i=0;
	while ((i<BIGN_MATR)&&(!erreur)) {
		j=0;
		while ((j<BIGN_MATR)&&(!erreur)){
			if (matrice[i][j]!=valeur) {
				erreur = 1;
				fprintf(stderr,"\n\tErreur sur la valeur d'une matrice à la colonne %i et ligne %i -> %f != %f.\n\n",j,i,valeur,matrice[i][j]);
			}
			j++;
		}
		i++;
	}
	return erreur;
}

int tout_ok (t_bfMatrVect vecteur, double valeur) {
	int i;
	int erreur = 0;
	i=0;
	while ((i<BIGN_MATR)&&(!erreur)) {
		if (vecteur[i]!=valeur) {
			erreur = 1;
			fprintf(stderr,"\n\tErreur sur la valeur du vecteur à ligne %i -> %f != %f.\n\n",i,valeur,vecteur[i]);
		}
		i++;
	}
	return erreur;
}

void init (t_bfMatrVect tab, double valeur) {
	int i;
	int j;
	for(i=0 ; i<BIGN_MATR ; i++){
		for(j=0 ; j<BIGN_MATR ; j++){
			tab[i] = valeur;
		}
	}
}

int main(int argc, char *argv[])
{
	double valeur1;
	double valeur2;
	double valeur3;
	double scalaire;

	/* On commence par vouloir tester les fonctions de lecture et d'écriture d'un vecteur */
   	/* 	void read_bfMatr(t_bfMatr aMatr); 	*/
	/*	void write_bfMatr(t_bfMatr aMatr);	*/

	/* On récupère la veleur que contient chaque composante du vecteur */
	if(scanf("%lf",&valeur1) != 1){ /* LECTURE d'une valeur */
		fprintf(stderr, "autre erreur[1]\n");
	}
	read_bfMatr(M1);  /* LECTURE d'une matrice */
	if (verifie_valeur(M1,valeur1)) {
		fprintf(stderr, "lecture incorrecte\n");
		return 1;
	}
	write_bfMatr(M1); /* ECRITURE d'une matrice */
	/* On testera cette procédure dans le shell avec un diff pour voir si la lecture et l'écriture marche bien */

	/* Test des fonctions ne manipulant que des matrices ou un double */
	/*	void add_bfMatr(t_bfMatr aMatr1, t_bfMatr aMatr2, t_bfMatr aMatr3);			*/
	/*	void mScalaire_bfMatr(t_bfMatr aMatr1, double aScalaire, t_bfMatr aMatr2);	*/
	/*	void mult_bfMatr(t_bfMatr aMatr1, t_bfMatr aMatr2, t_bfMatr aMatr3);		*/
	if(scanf("%lf",&scalaire) != 1){  /* LECTURE d'une valeur */
		fprintf(stderr, "autre erreur[3]\n");
		return 1;
	}
	valeur2 = valeur1 * scalaire;
	mScalaire_bfMatr(M1,scalaire,M2);
	if (verifie_valeur(M2,valeur2)) {
		fprintf(stderr, "multiplication externe incorrecte\n");
		return 1;
	} /* Si passe du if OK alors on connait la valeur de la matrice M2 */
	valeur3 = valeur1 + valeur2;
	add_bfMatr(M1,M2,M3);
	if (verifie_valeur(M3,valeur3)) {
		fprintf(stderr, "addition incorrecte\n");
		return 1;
	}
	valeur3 = BIGN_MATR * valeur1 * valeur2;
	mult_bfMatr(M1,M2,M3);
	if (verifie_valeur(M3,valeur3)) {
		fprintf(stderr, "multiplication matricielle incorrecte\n");
		return 1;
	}
	
	/* Test sur la procédure GAXPY */
	/*	void bfGaxpy(t_bfMatr aMatr, t_bfMatrVect x, t_bfMatrVect y, t_bfMatrVect result);	*/
	/* Utilisation d'un nouveau type : */
	/* 		typedef double t_bfMatrVect[BIGN_MATR];		*/
	if(scanf("%lf",&valeur2) != 1){  /* LECTURE d'une valeur */
		fprintf(stderr, "autre erreur[4]\n");
		return 1;
	}
	init(Vect_x,valeur2);
	if(scanf("%lf",&valeur3) != 1){  /* LECTURE d'une valeur */
		fprintf(stderr, "autre erreur[4]\n");
		return 1;
	}
	init(Vect_y,valeur3);
	bfGaxpy(M1,Vect_x,Vect_y,Vect_r);
	scalaire = (BIGN_MATR * valeur1 * valeur2) + valeur3;
	if (tout_ok(Vect_r,scalaire)) {
		fprintf(stderr, "autre erreur[4]\n");
		return 1;
	}

	/* Test sur la transposition : */
	/*	void transpo_bfMatr(t_bfMatr aMatr1); 	*/
	/* Utilisation d'un programme auxiliaire pour créer les matrices néssecaires */
	/* Utilisation d'un DIFF pour savoir si les lignes sont devenues les colonnes et inversement */
	read_bfMatr(M1); /* LECTURE d'une matrice */
	transpo_bfMatr(M1);	
	printf("\n"); /* pour avoir un saut de ligne de séparation */
	write_bfMatr(M1); /* ECRITURE d'une matrice */

	return 0;
}