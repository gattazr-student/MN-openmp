#include <stdio.h>
#include <vecteur.h>
#include <vectb.h>
#include <nmmintrin.h>

/* ========================================================================== */
/* Fonction d'addition de deux grands vecteurs de doubles */
void add_bdVect(t_bdVect aVect1, t_bdVect aVect2, t_bdVect aVect3){
	int wI,wJ;
	for (wI=0; wI<BIGN; wI+=BIGN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+BIGN/4) ; wJ++){
			aVect3[wJ] = aVect1[wJ] + aVect2[wJ];
		}
	}
}

/* Fonction d'addition de deux grands vecteurs de floats */
void add_bfVect(t_bfVect aVect1, t_bfVect aVect2, t_bfVect aVect3){
	int wI,wJ;
	for (wI=0; wI<BIGN; wI+=BIGN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+BIGN/4) ; wJ++){
			aVect3[wJ] = aVect1[wJ] + aVect2[wJ];
		}
	}
}

/* ========================================================================== */
/* Fonction vectorisé d'addition de deux grands vecteurs de doubles */
void addVect_bdVect(t_bdVect aVect1, t_bdVect aVect2, t_bdVect aVect3){
	int wI,wJ;
	__m128d wV1, wV2, wV3;

	for (wI=0; wI<BIGN; wI+=BIGN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ, wV1, wV2, wV3)
		for(wJ = wI; wJ < (wI+BIGN/4) ; wJ+=2){
			wV1 =_mm_load_pd(&(aVect1[wJ]));
			wV2 =_mm_load_pd(&(aVect2[wJ]));
			wV3 =_mm_add_pd(wV1,wV2);
			_mm_store_pd(&(aVect3[wJ]), wV3);
		}
	}
}

/* Fonction vectorisé d'addition de deux grands vecteurs de floats */
void addVect_bfVect(t_bfVect aVect1, t_bfVect aVect2, t_bfVect aVect3){
	int wI,wJ;
	__m128 wV1, wV2, wV3;

	for (wI=0; wI<BIGN; wI+=BIGN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ, wV1, wV2, wV3)
		for(wJ = wI; wJ < (wI+BIGN/4) ; wJ+=4){
			wV1 =_mm_load_ps(&(aVect1[wJ]));
			wV2 =_mm_load_ps(&(aVect2[wJ]));
			wV3 =_mm_add_ps(wV1,wV2);
			_mm_store_ps(&(aVect3[wJ]), wV3);
		}
	}
}

/* ========================================================================== */
/* Fonction multiplication d'un grand vecteur de doubles par un scalaire */
void mScalaire_bdVect(t_bdVect aVect1, double aScalaire, t_bdVect aVect2){
	int wI,wJ;
	for (wI=0; wI<BIGN; wI+=BIGN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+BIGN/4) ; wJ++){
			aVect2[wJ] = aVect1[wJ] * aScalaire;
		}
	}
}

/* Fonction multiplication d'un grand vecteur de floats par un scalaire */
void mScalaire_bfVect(t_bfVect aVect1, float aScalaire, t_bfVect aVect2){
	int wI,wJ;
	for (wI=0; wI<BIGN; wI+=BIGN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+BIGN/4) ; wJ++){
			aVect2[wJ] = aVect1[wJ] * aScalaire;
		}
	}
}

/* ========================================================================== */
/* Fonction produit scalaire de deux grands vecteurs de doubles */
double pScalaire_bdVect(t_bdVect aVect1, t_bdVect aVect2){
	double wReturned = 0;
	int wI,wJ;
	for (wI=0; wI<BIGN; wI+=BIGN/4){
		#pragma omp parallel for reduction(+:wReturned) firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+BIGN/4) ; wJ++){
			wReturned += aVect1[wJ]*aVect2[wJ];
		}
	}
	return wReturned;
}

/* Fonction produit scalaire de deux grands vecteurs de floats */
float pScalaire_bfVect(t_bfVect aVect1, t_bfVect aVect2){
	float wReturned = 0;
	int wI,wJ;
	for (wI=0; wI<BIGN; wI+=BIGN/4){
		#pragma omp parallel for reduction(+:wReturned) firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+BIGN/4) ; wJ++){
			wReturned += aVect1[wJ]*aVect2[wJ];
		}
	}
	return wReturned;
}

/* ========================================================================== */
/* Fonction produit scalaire vectorisé de deux grands vecteurs de doubles */
double pScalaireVect_bdVect(t_bdVect aVect1, t_bdVect aVect2){
	__m128d wV1, wV2, wRes;
	double wReturned = 0;
	int wI,wJ;
	for (wI=0; wI<BIGN; wI+=BIGN/4){
		#pragma omp parallel for reduction(+:wReturned) firstprivate(wI) private(wJ, wV1, wV2, wRes)
		for(wJ = wI; wJ < (wI+BIGN/4) ; wJ+=2){
			wV1 =_mm_load_pd(&(aVect1[wJ]));
			wV2 =_mm_load_pd(&(aVect2[wJ]));
			wRes = _mm_dp_pd(wV1, wV2, 0xFF);

			wReturned += wRes[0];
		}
	}
	return wReturned;
}

/* Fonction produit scalaire vectorisé de deux grands vecteurs de floats */
float pScalaireVect_bfVect(t_bfVect aVect1, t_bfVect aVect2){
	__m128 wV1, wV2, wRes;
	double wReturned = 0;
	int wI,wJ;
	for (wI=0; wI<BIGN; wI+=BIGN/4){
		#pragma omp parallel for reduction(+:wReturned) firstprivate(wI) private(wJ, wV1, wV2, wRes)
		for(wJ = wI; wJ < (wI+BIGN/4) ; wJ+=4){
			wV1 =_mm_load_ps(&(aVect1[wJ]));
			wV2 =_mm_load_ps(&(aVect2[wJ]));
			wRes = _mm_dp_ps(wV1, wV2, 0xFF);

			wReturned += wRes[0];
		}
	}
	return wReturned;
}

/* ========================================================================== */
/* Fonction de lecture d'un vecteur de type t_bdVect */
void read_bdVect(t_bdVect aVect){
	int wJ;
	for (wJ=0; wJ<BIGN; wJ++){
		scanf("%lf", &aVect[wJ]);
	}
}

/* Fonction de lecture d'un vecteur de type t_bfVect */
void read_bfVect(t_bfVect aVect){
	int wJ;
	for (wJ=0; wJ<BIGN; wJ++){
		scanf("%f", &aVect[wJ]);
	}
}

/* ========================================================================== */
/* Fonction d'écriture d'un vecteur de type t_bdVect */
void write_bdVect(t_bdVect aVect){
	int wJ;
	for (wJ=0; wJ<BIGN; wJ++){
		fprintf(stdout, "%f\n", aVect[wJ]);
	}
}

/* Fonction d'écriture d'un vecteur de type t_bfVect */
void write_bfVect(t_bfVect aVect){
	int wJ;
	for (wJ=0; wJ<BIGN; wJ++){
		fprintf(stdout, "%f\n", aVect[wJ]);
	}
}
