#include "vecteur.h"

/* Définitions des types petits vecteurs */
typedef double t_sdVect[SMALLN] __attribute__ ((aligned (16)));
typedef float t_sfVect[SMALLN] __attribute__ ((aligned (16)));

/* Fonctions addition de deux grands vecteurs */
void add_sdVect(t_sdVect aVect1, t_sdVect aVect2, t_sdVect aVect3);
void add_sfVect(t_sfVect aVect1, t_sfVect aVect2, t_sfVect aVect3);

/* Fonctions vectorisés addition de deux petits vecteurs */
void addVect_sdVect(t_sdVect aVect1, t_sdVect aVect2, t_sdVect aVect3);
void addVect_sfVect(t_sfVect aVect1, t_sfVect aVect2, t_sfVect aVect3);

/* Fonctions multiplication d'un grand vecteur par un scalaire */
void mScalaire_sdVect(t_sdVect aVect1, double aScalaire, t_sdVect aVect2);
void mScalaire_sfVect(t_sfVect aVect1, float aScalaire, t_sfVect aVect2);

/* Fonctions produit scalaire de deux grands vecteurs */
double pScalaire_sdVect(t_sdVect aVect1, t_sdVect aVect2);
float pScalaire_sfVect(t_sfVect aVect1, t_sfVect aVect2);

/* Fonctions vectorisés produit scalaire de deux petits vecteurs */
double pScalaireVect_sdVect(t_sdVect aVect1, t_sdVect aVect2);
float pScalaireVect_sfVect(t_sfVect aVect1, t_sfVect aVect2);

/* Fonctions de lectures de vecteur (depuis stdin) */
void read_sdVect(t_sdVect aVect);
void read_sfVect(t_sfVect aVect);

/* Fonctions d'écriture d'un vecteur (dans stdout) */
void write_sdVect(t_sdVect aVect);
void write_sfVect(t_sfVect aVect);
