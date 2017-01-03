#include <stdio.h>
#include <libgen.h>
#include <matrs.h>
#include <sys/time.h>
#include <sys/resource.h>
#include "myTime.h"

#define NB_TEST 250000

t_sdMatr M1, M2, M3;

int main(int aArgc, char **aArgv){
	/* Test de performance de la fonction addVect_sdMatr */
    /* La fonction va être effectue NB_TEST fois */
	struct rusage wUsage;
    struct timeval wStart, wEnd, wResult;
    int wI = 0;

    /* Initialisation des matrices */
    read_sdMatr(M1);
    read_sdMatr(M2);

    /* Récupération du temp de début */
    getrusage(RUSAGE_SELF, &wUsage);
    wStart = wUsage.ru_utime;

    /* La fonction */
    while(wI < NB_TEST){
        addVect_sdMatr(M1,M2,M3);
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
