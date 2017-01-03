#include <stdio.h>
#include <libgen.h>
#include <vects.h>
#include <sys/time.h>
#include <sys/resource.h>
#include "myTime.h"

#define NB_TEST 5000000

t_sdVect V1, V2,V3;

int main(int aArgc, char **aArgv){
    /* Test de performance de la fonction pScalaire_sdVect */
    /* La fonction va être effectue NB_TEST fois */
    struct rusage wUsage;
    struct timeval wStart, wEnd, wResult;
    int wI = 0;
    double wScalaire;

    /* Initialisation de deux vecteurs */
    read_sdVect(V1);
    read_sdVect(V2);

    /* Récupération du temp de début */
    getrusage(RUSAGE_SELF, &wUsage);
    wStart = wUsage.ru_utime;

    /* La fonction */
    while(wI < NB_TEST){
        wScalaire = pScalaireVect_sdVect(V1, V2);
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
    fprintf(stdout, "Opérations par boucle: %d\n", 2*SMALLN);
    fprintf(stdout, "Temps d'execution user: %ld.%ld\n", wResult.tv_sec, wResult.tv_usec);
    return 0;
}
