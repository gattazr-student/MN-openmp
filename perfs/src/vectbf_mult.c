#include <stdio.h>
#include <libgen.h>
#include <vectb.h>
#include <sys/time.h>
#include <sys/resource.h>
#include "myTime.h"

#define NB_TEST 5000

t_bfVect V1, V2;

int main(int aArgc, char **aArgv){
    /* Test de performance de la fonction mScalaire_bfVect */
    /* La fonction va être effectue NB_TEST fois */
    struct rusage wUsage;
    struct timeval wStart, wEnd, wResult;
    int wI = 0;
    float wScalaire;

    /* Initialisation du vecteur */
    read_bfVect(V1);
    if (scanf("%f", &wScalaire) != 1){
        fprintf(stderr, "Erreur lors de la lecture du scalaire\n");
        return 1;
    }

    /* Récupération du temp de début */
    getrusage(RUSAGE_SELF, &wUsage);
    wStart = wUsage.ru_utime;

    /* La fonction */
    while(wI < NB_TEST){
        mScalaire_bfVect(V1, wScalaire, V2);
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
    fprintf(stdout, "Opérations par boucle: %d\n", BIGN);
    fprintf(stdout, "Temps d'execution user: %ld.%ld\n", wResult.tv_sec, wResult.tv_usec);
    return 0;
}
