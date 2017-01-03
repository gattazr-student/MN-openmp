#include "matrice.h"

/* Définitions des types petites Matrices */
typedef double t_sdMatr[SMALLN_MATR][SMALLN_MATR] __attribute__ ((aligned (16)));
typedef float t_sfMatr[SMALLN_MATR][SMALLN_MATR] __attribute__ ((aligned (16)));
/* Definition de petits vecteurs */
typedef double t_sdMatrVect[SMALLN_MATR] __attribute__ ((aligned (16)));
typedef float t_sfMatrVect[SMALLN_MATR] __attribute__ ((aligned (16)));

/* Fonctions d'addition de deux petites Matrices */
void add_sdMatr(t_sdMatr aMatr1, t_sdMatr aMatr2, t_sdMatr aMatr3);
void add_sfMatr(t_sfMatr aMatr1, t_sfMatr aMatr2, t_sfMatr aMatr3);

/* Fonctions vectorisés d'addition de deux petites Matrices */
void addVect_sdMatr(t_sdMatr aMatr1, t_sdMatr aMatr2, t_sdMatr aMatr3);
void addVect_sfMatr(t_sfMatr aMatr1, t_sfMatr aMatr2, t_sfMatr aMatr3);

/* Fonction factorisation LU de petite matrices */
void factLU_sdMatr(t_sdMatr aMatrice, t_sdMatr aMatrL, t_sdMatr aMatrU);
void factLU_sfMatr(t_sfMatr aMatrice, t_sfMatr aMatrL, t_sfMatr aMatrU);

/* Gaxpy (Generalizef Ax plus y) */
void sdGaxpy(t_sdMatr aMatr, t_sdMatrVect x, t_sdMatrVect y, t_sdMatrVect result);
void sfGaxpy(t_sfMatr aMatr, t_sfMatrVect x, t_sfMatrVect y, t_sfMatrVect result);

/* Fonctions multiplication d'une petite Matrice par un scalaire */
void mScalaire_sdMatr(t_sdMatr aMatr1, double aScalaire, t_sdMatr aMatr2);
void mScalaire_sfMatr(t_sfMatr aMatr1, float aScalaire, t_sfMatr aMatr2);

/* Fonctions de multiplications de petites matrices */
void mult_sdMatr(t_sdMatr aMatr1, t_sdMatr aMatr2, t_sdMatr aMatr3);
void mult_sfMatr(t_sfMatr aMatr1, t_sfMatr aMatr2, t_sfMatr aMatr3);

/* Fonctions vectorisés de multiplications de petites matrices */
void multVect_sdMatr(t_sdMatr aMatr1, t_sdMatr aMatr2, t_sdMatr aMatr3);
void multVect_sfMatr(t_sfMatr aMatr1, t_sfMatr aMatr2, t_sfMatr aMatr3);

/* Fonction de transposition d'une petite matrice */
void transpo_sdMatr(t_sdMatr aMatr1);
void transpo_sfMatr(t_sfMatr aMatr1);

/* Fonctions de lecture de Matrice (depuis stdin) */
void read_sdMatr(t_sdMatr aMatr);
void read_sfMatr(t_sfMatr aMatr);

/* Fonctions de lecture de MatriceVect (depuis stdin) */
void read_sdMatrVect(t_sdMatrVect aMatr);
void read_sfMatrVect(t_sfMatrVect aMatr);

/* Fonctions d'écriture d'une Matrice (dans stdout) */
void write_sdMatr(t_sdMatr aMatr);
void write_sfMatr(t_sfMatr aMatr);

/* Fonctions d'écriture d'une MatriceVect (dans stdout) */
void write_sdMatrVect(t_sdMatrVect aMatr);
void write_sfMatrVect(t_sfMatrVect aMatr);
