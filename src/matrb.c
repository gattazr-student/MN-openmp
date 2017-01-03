#include <matrice.h>
#include <matrb.h>
#include <stdio.h>
#include <nmmintrin.h>

/* ========================================================================== */
/* Fonction d'addition de deux grandes matrices de doubles */
void add_bdMatr(t_bdMatr aMatr1, t_bdMatr aMatr2, t_bdMatr aMatr3){
	int wI,wJ;
	#pragma omp parallel for private(wI, wJ)
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < BIGN_MATR ; wJ++){
			aMatr3[wI][wJ] = aMatr1[wI][wJ] + aMatr2[wI][wJ];
		}
	}
}

/* Fonction d'addition de deux grands matrices de floats */
void add_bfMatr(t_bfMatr aMatr1, t_bfMatr aMatr2, t_bfMatr aMatr3){
	int wI,wJ;
	#pragma omp parallel for private(wI, wJ)
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < BIGN_MATR ; wJ++){
			aMatr3[wI][wJ] = aMatr1[wI][wJ] + aMatr2[wI][wJ];
		}
	}
}

/* ========================================================================== */
/* Fonction vectorisé d'addition de deux grandes matrices de doubles */
void addVect_bdMatr(t_bdMatr aMatr1, t_bdMatr aMatr2, t_bdMatr aMatr3){
	int wI,wJ;
	__m128d wV1, wV2, wV3;

	#pragma omp parallel for private(wI, wJ, wV1, wV2, wV3)
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < BIGN_MATR ; wJ+=2){
			wV1 =_mm_load_pd(&(aMatr1[wI][wJ]));
			wV2 =_mm_load_pd(&(aMatr2[wI][wJ]));
			wV3 =_mm_add_pd(wV1,wV2);
			_mm_store_pd(&(aMatr3[wI][wJ]), wV3);
		}
	}
}

/* Fonction vectorisé d'addition de deux grands matrices de floats */
void addVect_bfMatr(t_bfMatr aMatr1, t_bfMatr aMatr2, t_bfMatr aMatr3){
	int wI,wJ;
	__m128 wV1, wV2, wV3;

	#pragma omp parallel for private(wI, wJ, wV1, wV2, wV3)
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < BIGN_MATR ; wJ+=2){
			wV1 =_mm_load_ps(&(aMatr1[wI][wJ]));
			wV2 =_mm_load_ps(&(aMatr2[wI][wJ]));
			wV3 =_mm_add_ps(wV1,wV2);
			_mm_store_ps(&(aMatr3[wI][wJ]), wV3);
		}
	}
}


/* ========================================================================== */
/* Factorisation LU d'une grande matrice de doubles */
void factLU_bdMatr(t_bdMatr aMatrice, t_bdMatr aMatrL, t_bdMatr aMatrU){
	int wI,wJ,k,err;
	double pivot,coef;

	aMatrU = aMatrice;
	err = 1;
	k = 1;

	while (err==1 && k < BIGN_MATR){
		pivot = aMatrU[k][k];
		if(pivot != 0){
			for(wI = k + 1; wI <= BIGN_MATR; wI++){
				coef = aMatrU[wI][k] / pivot;
				for(wJ = k + 1; wJ <= BIGN_MATR; wJ++){
					aMatrU[wI][wJ] -= coef * aMatrU[k][wJ];
					aMatrL[wI][k ]  = coef;
				}
			}
		}
		else err = 0;
		k++;
	}
}

/* Factorisation LU d'une grande matrice de floats */
void factLU_bfMatr(t_bfMatr aMatrice, t_bfMatr aMatrL, t_bfMatr aMatrU){
	int wI,wJ,k,err;
	float pivot,coef;

	aMatrU = aMatrice;
	err = 1;
	k = 1;

	while (err==1 && k < BIGN_MATR){
		pivot = aMatrU[k][k];
		if(pivot != 0){
			for(wI = k + 1; wI <= BIGN_MATR; wI++){
				coef = aMatrU[wI][k] / pivot;
				for(wJ = k + 1; wJ <= BIGN_MATR; wJ++){
					aMatrU[wI][wJ] -= coef * aMatrU[k][wJ];
					aMatrL[wI][k ]  = coef;
				}
			}
		}
		else err = 0;
		k++;
	}
}

/* ========================================================================== */
/* Gaxpy (Generalizef Ax plus y) pour les grands doubles */
void bdGaxpy(t_bdMatr aMatr, t_bdMatrVect aX, t_bdMatrVect aY, t_bdMatrVect aResult){
	int wI,wJ;
	int wSomme;
	#pragma omp parallel shared(aMatr, aX, aY, aResult) private(wI, wJ, wSomme)
	{
		#pragma omp for schedule(static)
		for(wI=0;wI<BIGN_MATR;wI++){
			wSomme=0;
			for(wJ=0;wJ<BIGN_MATR;wJ++){
				wSomme = wSomme + aMatr[wI][wJ] * aX[wJ];
			}
			aResult[wI] = wSomme + aY[wI];
		}
	}
}

/* Gaxpy (Generalizef Ax plus y) pour les grands floats */
void bfGaxpy(t_bfMatr aMatr, t_bfMatrVect aX, t_bfMatrVect aY, t_bfMatrVect aResult){
	int wI,wJ;
	int wSomme;
	#pragma omp parallel shared(aMatr, aX, aY, aResult) private(wI, wJ, wSomme)
	{
		#pragma omp for schedule(static)
		for(wI=0;wI<BIGN_MATR;wI++){
			wSomme=0;
			for(wJ=0;wJ<BIGN_MATR;wJ++){
				wSomme = wSomme + aMatr[wI][wJ] * aX[wJ];
			}
			aResult[wI] = wSomme + aY[wI];
		}
	}
}

/* ========================================================================== */
/* Fonction multiplication d'un grand matrice de doubles par un scalaire */
void mScalaire_bdMatr(t_bdMatr aMatr1, double aScalaire, t_bdMatr aMatr2){
	int wI,wJ;
	#pragma omp parallel for private(wI, wJ)
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < BIGN_MATR ; wJ++){
			aMatr2[wI][wJ] = aMatr1[wI][wJ] * aScalaire;
		}
	}
}

/* Fonction multiplication d'un grand matrice de float par un scalaire */
void mScalaire_bfMatr(t_bfMatr aMatr1, float aScalaire, t_bfMatr aMatr2){
	int wI,wJ;
	#pragma omp parallel for private(wI, wJ)
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < BIGN_MATR ; wJ++){
			aMatr2[wI][wJ] = aMatr1[wI][wJ] * aScalaire;
		}
	}
}

/* ========================================================================== */
/* Multiplication de deux grandes matrices carrées de même dimension en double */
void mult_bdMatr(t_bdMatr aMatr1, t_bdMatr aMatr2, t_bdMatr aMatr3){
	int wI,wJ,wK;

	#pragma omp parallel shared(aMatr1, aMatr2, aMatr3) private(wI, wJ, wK)
	{
		#pragma omp for schedule(static)
		for(wI = 0; wI < BIGN_MATR ; wI++){
			for(wJ = 0; wJ < BIGN_MATR ; wJ++){
				aMatr3[wI][wJ] = 0;
				for(wK = 0; wK < BIGN_MATR ; wK++){
					aMatr3[wI][wJ] += (aMatr1[wI][wK] * aMatr2[wK][wJ]);
				}
			}
		}
	}
}

/* Multiplication de deux grandes matrices carrées de même dimension en double */
void mult_bfMatr(t_bfMatr aMatr1, t_bfMatr aMatr2, t_bfMatr aMatr3){
	int wI,wJ,wK;

	#pragma omp parallel shared(aMatr1, aMatr2, aMatr3) private(wI, wJ, wK)
	{
		#pragma omp for schedule(static)
		for(wI = 0; wI < BIGN_MATR ; wI++){
			for(wJ = 0; wJ < BIGN_MATR ; wJ++){
				aMatr3[wI][wJ] = 0;
				for(wK = 0; wK < BIGN_MATR ; wK++){
					aMatr3[wI][wJ] += (aMatr1[wI][wK] * aMatr2[wK][wJ]);
				}
			}
		}
	}
}

/* ========================================================================== */
/* Fonction vecotirsé multiplication de deux grandes matrices carrées de même dimension en double */
void multVect_bdMatr(t_bdMatr aMatr1, t_bdMatr aMatr2, t_bdMatr aMatr3){
	int wI,wJ,wK;
	__m128d wV1, wV2, wV3;
	double wTemp[4] __attribute__ ((aligned (16)));

	#pragma omp parallel shared(aMatr1, aMatr2, aMatr3) private(wTemp, wI, wJ, wK)
	{
		#pragma omp for schedule(static)
		for(wI = 0; wI < BIGN_MATR ; wI++){
			for(wJ = 0; wJ < BIGN_MATR ; wJ++){
				aMatr3[wI][wJ] = 0;
				for(wK = 0; wK < BIGN_MATR; wK+=2){
					wTemp[0] = aMatr2[wK][wJ];
					wTemp[1] = aMatr2[wK+1][wJ];
					wTemp[2] = aMatr2[wK+2][wJ];
					wTemp[3] = aMatr2[wK+3][wJ];

					wV1 =_mm_load_pd(&(aMatr1[wI][wK]));
					wV2 =_mm_load_pd(wTemp);
					wV3 = _mm_dp_pd(wV1, wV2, 0xFF);
					_mm_store_pd(wTemp, wV3);
					aMatr3[wI][wJ] += wTemp[0];
				}
			}
		}
	}
}

/* Fonction vectorisé multiplication de deux grandes matrices carrées de même dimension en double */
void multVect_bfMatr(t_bfMatr aMatr1, t_bfMatr aMatr2, t_bfMatr aMatr3){
	int wI,wJ,wK;
	__m128 wV1, wV2, wV3;
	float wTemp[4] __attribute__ ((aligned (16)));

	#pragma omp parallel shared(aMatr1, aMatr2, aMatr3) private(wTemp, wI, wJ, wK)
	{
		#pragma omp for schedule(static)
		for(wI = 0; wI < BIGN_MATR ; wI++){
			for(wJ = 0; wJ < BIGN_MATR ; wJ++){
				aMatr3[wI][wJ] = 0;
				for(wK = 0; wK < BIGN_MATR; wK+=4){
					wTemp[0] = aMatr2[wK][wJ];
					wTemp[1] = aMatr2[wK+1][wJ];
					wTemp[2] = aMatr2[wK+2][wJ];
					wTemp[3] = aMatr2[wK+3][wJ];

					wV1 =_mm_load_ps(&(aMatr1[wI][wK]));
					wV2 =_mm_load_ps(wTemp);
					wV3 = _mm_dp_ps(wV1, wV2, 0xFF);
					_mm_store_ps(wTemp, wV3);
					aMatr3[wI][wJ] += wTemp[0];
				}
			}
		}
	}
}

/* ========================================================================== */
/* Fonction de transposition avec deux matrices de double : donnée et sortie */
void transpo_bdMatr(t_bdMatr aMatr1){
	int wI,wJ;
	double wTemp;

	#pragma omp parallel for private(wI, wJ, wTemp) schedule(dynamic)
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < wI ; wJ++){
			wTemp = aMatr1[wI][wJ];
			aMatr1[wI][wJ] = aMatr1[wJ][wI];
			aMatr1[wJ][wI] = wTemp;
		}
	}
}

/* Fonction de transposition avec deux matrices de floats : donnée et sortie */
void transpo_bfMatr(t_bfMatr aMatr1){
	int wI,wJ;
	float wTemp;

	#pragma omp parallel for private(wI, wJ, wTemp) schedule(dynamic)
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < wI ; wJ++){
			wTemp = aMatr1[wI][wJ];
			aMatr1[wI][wJ] = aMatr1[wJ][wI];
			aMatr1[wJ][wI] = wTemp;
		}
	}
}


/* ========================================================================== */
/* Fonction de lecture d'un matrice de type t_bdMatr */
void read_bdMatr(t_bdMatr aMatr){
	int wI,wJ;
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < BIGN_MATR ; wJ++){
			if (scanf("%lf", &aMatr[wI][wJ]) != 1){
				fprintf(stderr, "erreur lors de la lecture de la matrice à l'indice %d%d\n", wI, wJ);
				return;
			}
		}
	}
}

/* Fonction de lecture d'un matrice de type t_bfMatr */
void read_bfMatr(t_bfMatr aMatr){
	int wI,wJ;
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < BIGN_MATR ; wJ++){
			if (scanf("%f", &aMatr[wI][wJ]) != 1){
				fprintf(stderr, "erreur lors de la lecture de la matrice à l'indice %d%d\n", wI, wJ);
				return;
			}
		}
	}
}

/* ========================================================================== */
/* Fonction de lecture d'un matrice de type t_sdMatrVect */
void read_bdMatrVect(t_bdMatrVect aMatr){
	int wI;
	for(wI = 0; wI < BIGN_MATR ; wI++){
		if (scanf("%lf", &aMatr[wI]) != 1){
			fprintf(stderr, "erreur lors de la lecture de la matrice à l'indice %d\n", wI);
			return;
		}
	}
}

/* Fonction de lecture d'un matrice de type t_sfMatrVect */
void read_bfMatrVect(t_bfMatrVect aMatr){
	int wI;
	for(wI = 0; wI < SMALLN_MATR ; wI++){
		if (scanf("%f", &aMatr[wI]) != 1){
			fprintf(stderr, "erreur lors de la lecture de la matrice à l'indice %d\n", wI);
			return;
		}
	}
}

/* ========================================================================== */
/* Fonction d'écriture d'un matrice de type t_bdMatr */
void write_bdMatr(t_bdMatr aMatr){
	int wI,wJ;
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < BIGN_MATR ; wJ++){
			fprintf(stdout, "%.1f ", aMatr[wI][wJ]);
		}
		fprintf(stdout, "\n");
	}
}

/* Fonction d'écriture d'un matrice de type t_bfMatr */
void write_bfMatr(t_bfMatr aMatr){
	int wI,wJ;
	for(wI = 0; wI < BIGN_MATR ; wI++){
		for(wJ = 0; wJ < BIGN_MATR ; wJ++){
			fprintf(stdout, "%.1f ", aMatr[wI][wJ]);
		}
		fprintf(stdout, "\n");
	}
}

/* ========================================================================== */
/* Fonction d'écriture d'un matrice de type t_bdMatrVect */
void write_bdMatrVect(t_bdMatrVect aMatrVect){
	int wI;
	for(wI = 0; wI < BIGN_MATR ; wI++){
		fprintf(stdout, "%f\n", aMatrVect[wI]);
	}
}

/* Fonction d'écriture d'un matrice de type t_bdMatrVect */
void write_bfMatrVect(t_bfMatrVect aMatrVect){
	int wI;
	for(wI = 0; wI < BIGN_MATR ; wI++){
		fprintf(stdout, "%f\n", aMatrVect[wI]);
	}
}
