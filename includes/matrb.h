#include "matrice.h"

/* Définitions des types grandes Matrices */
typedef double t_bdMatr[BIGN_MATR][BIGN_MATR] __attribute__ ((aligned (16)));
typedef float t_bfMatr[BIGN_MATR][BIGN_MATR] __attribute__ ((aligned (16)));
/* Definition de grands vecteurs */
typedef double t_bdMatrVect[BIGN_MATR] __attribute__ ((aligned (16)));
typedef float t_bfMatrVect[BIGN_MATR] __attribute__ ((aligned (16)));

/* Fonctions d'addition de deux grandes Matrices */
void add_bdMatr(t_bdMatr aMatr1, t_bdMatr aMatr2, t_bdMatr aMatr3);
void add_bfMatr(t_bfMatr aMatr1, t_bfMatr aMatr2, t_bfMatr aMatr3);

/* Fonctions vectorisés d'addition de deux grandes Matrices */
void addVect_bdMatr(t_bdMatr aMatr1, t_bdMatr aMatr2, t_bdMatr aMatr3);
void addVect_bfMatr(t_bfMatr aMatr1, t_bfMatr aMatr2, t_bfMatr aMatr3);

/* Fonctions factorisation LU de grandes matrice */
void factLU_bdMatr(t_bdMatr aMatrice, t_bdMatr aMatrL, t_bdMatr aMatrU);
void factLU_bfMatr(t_bfMatr aMatrice, t_bfMatr aMatrL, t_bfMatr aMatrU);

/* Gaxpy (Generalizef Ax plus y) */
void bdGaxpy(t_bdMatr aMatr, t_bdMatrVect x, t_bdMatrVect y, t_bdMatrVect result);
void bfGaxpy(t_bfMatr aMatr, t_bfMatrVect x, t_bfMatrVect y, t_bfMatrVect result);

/* Fonctions multiplication d'une grande Matrice par un scalaire */
void mScalaire_bdMatr(t_bdMatr aMatr1, double aScalaire, t_bdMatr aMatr2);
void mScalaire_bfMatr(t_bfMatr aMatr1, float aScalaire, t_bfMatr aMatr2);

/* Fonctions de multiplications de grandes matrices */
void mult_bdMatr(t_bdMatr aMatr1, t_bdMatr aMatr2, t_bdMatr aMatr3);
void mult_bfMatr(t_bfMatr aMatr1, t_bfMatr aMatr2, t_bfMatr aMatr3);

/* Fonctions vectorisés de multiplications de grandes matrices */
void multVect_bdMatr(t_bdMatr aMatr1, t_bdMatr aMatr2, t_bdMatr aMatr3);
void multVect_bfMatr(t_bfMatr aMatr1, t_bfMatr aMatr2, t_bfMatr aMatr3);

/* Fonction de transposition d'une grande matrice */
void transpo_bdMatr(t_bdMatr aMatr1);
void transpo_bfMatr(t_bfMatr aMatr1);

/* Fonctions de lecture de Matrice (depuis stdin) */
void read_bdMatr(t_bdMatr aMatr);
void read_bfMatr(t_bfMatr aMatr);

/* Fonctions de lecture de MatriceVect (depuis stdin) */
void read_bdMatrVect(t_bdMatrVect aMatr);
void read_bfMatrVect(t_bfMatrVect aMatr);

/* Fonctions d'écriture d'un Matrice (dans stdout) */
void write_bdMatr(t_bdMatr aMatr);
void write_bfMatr(t_bfMatr aMatr);

/* Fonctions d'écriture d'une MatriceVect (dans stdout) */
void write_bdMatrVect(t_bdMatrVect aMatr);
void write_bfMatrVect(t_bfMatrVect aMatr);
