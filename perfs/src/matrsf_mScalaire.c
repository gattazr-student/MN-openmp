#include <stdio.h>
#include <libgen.h>
#include <matrs.h>
#include <sys/time.h>
#include <sys/resource.h>
#include "myTime.h"

#define NB_TEST 250000

t_sfMatr M1, M2;

int main(int aArgc, char **aArgv){
	/* Test de performance de la fonction mScalaire_sfMatr */
    /* La fonction va être effectue NB_TEST fois */
	struct rusage wUsage;
    struct timeval wStart, wEnd, wResult;
    int wI = 0;
    float wScalaire;

    /* Initialisation de la matrice */
    read_sfMatr(M1);
    if (scanf("%f", &wScalaire) != 1){
        fprintf(stderr, "Erreur lors de la lecture du scalaire\n");
        return 1;
    }

    /* Récupération du temp de début */
    getrusage(RUSAGE_SELF, &wUsage);
    wStart = wUsage.ru_utime;

    /* La fonction */
    while(wI < NB_TEST){
        mScalaire_sfMatr(M1, wScalaire, M2);
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
    fprintf(stdout, "Opérations par boucle: %d\n", SMALLN_MATR*SMALLN_MATR);
    fprintf(stdout, "Temps d'execution user: %ld.%ld\n", wResult.tv_sec, wResult.tv_usec);
    return 0;
}
