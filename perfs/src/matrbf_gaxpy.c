#include <stdio.h>
#include <libgen.h>
#include <matrb.h>
#include <sys/time.h>
#include <sys/resource.h>
#include "myTime.h"

#define NB_TEST 6400

t_bfMatr M1;
t_bfMatrVect X, Y, RES;

int main(int aArgc, char **aArgv){
	/* Test de performance de la fonction bfGaxpy */
    /* La fonction va être effectue NB_TEST fois */
	struct rusage wUsage;
    struct timeval wStart, wEnd, wResult;
    int wI = 0;

    /* Initialisation de la matrice */
    read_bfMatr(M1);

    /* Intialisation des vecteurs X et Y */
    read_bfMatrVect(X);
    read_bfMatrVect(Y);

    /* Récupération du temp de début */
    getrusage(RUSAGE_SELF, &wUsage);
    wStart = wUsage.ru_utime;

    /* La fonction */
    while(wI < NB_TEST){
        bfGaxpy(M1, X, Y, RES);
        wI++;
    }

    /* Récupération du temp de fin */
    getrusage(RUSAGE_SELF, &wUsage);
    wEnd = wUsage.ru_utime;

    /* calcul du temps d'execution (user) */
    timeval_subtract(&wResult, &wEnd, &wStart);

    /* Affichage des résultats */
    fprintf(stdout, "Fonction: %s\n", basename(aArgv[0]));
    fprintf(stdout, "Occurences: %d\n", wI);
    fprintf(stdout, "Opérations par boucle: %d\n", BIGN_MATR*BIGN_MATR);
    fprintf(stdout, "Temps d'execution user: %ld.%ld\n", wResult.tv_sec, wResult.tv_usec);
    return 0;
}
