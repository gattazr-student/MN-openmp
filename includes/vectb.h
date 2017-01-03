#include "vecteur.h"

/* Définitions des types grands vecteurs */
typedef double t_bdVect[BIGN] __attribute__ ((aligned (16)));
typedef float t_bfVect[BIGN] __attribute__ ((aligned (16)));

/* Fonctions addition de deux grands vecteurs */
void add_bdVect(t_bdVect aVect1, t_bdVect aVect2, t_bdVect aVect3);
void add_bfVect(t_bfVect aVect1, t_bfVect aVect2, t_bfVect aVect3);

/* Fonctions vectorisés addition de deux grands vecteurs */
void addVect_bdVect(t_bdVect aVect1, t_bdVect aVect2, t_bdVect aVect3);
void addVect_bfVect(t_bfVect aVect1, t_bfVect aVect2, t_bfVect aVect3);

/* Fonctions multiplication d'un grand vecteur par un scalaire */
void mScalaire_bdVect(t_bdVect aVect1, double aScalaire, t_bdVect aVect2);
void mScalaire_bfVect(t_bfVect aVect1, float aScalaire, t_bfVect aVect2);

/* Fonctions produit scalaire de deux grands vecteurs */
double pScalaire_bdVect(t_bdVect aVect1, t_bdVect aVect2);
float pScalaire_bfVect(t_bfVect aVect1, t_bfVect aVect2);

/* Fonctions vectorisés produit scalaire de deux grands vecteurs */
double pScalaireVect_bdVect(t_bdVect aVect1, t_bdVect aVect2);
float pScalaireVect_bfVect(t_bfVect aVect1, t_bfVect aVect2);

/* Fonctions de lectures de vecteur (depuis stdin) */
void read_bdVect(t_bdVect aVect);
void read_bfVect(t_bfVect aVect);

/* Fonctions d'écriture d'un vecteur (dans stdout) */
void write_bdVect(t_bdVect aVect);
void write_bfVect(t_bfVect aVect);
