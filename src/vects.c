#include <stdio.h>
#include <vecteur.h>
#include <vects.h>
#include <nmmintrin.h>

/* ========================================================================== */
/* Fonction d'addition de deux petits vecteurs de doubles */
void add_sdVect(t_sdVect aVect1, t_sdVect aVect2, t_sdVect aVect3){
	int wI,wJ;
	for (wI=0; wI<SMALLN; wI+=SMALLN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+SMALLN/4) ; wJ++){
			aVect3[wJ] = aVect1[wJ] + aVect2[wJ];
		}
	}
}

/* Fonction d'addition de deux petits vecteurs de floats */
void add_sfVect(t_sfVect aVect1, t_sfVect aVect2, t_sfVect aVect3){
	int wI,wJ;
	for (wI=0; wI<SMALLN; wI+=SMALLN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+SMALLN/4) ; wJ++){
			aVect3[wJ] = aVect1[wJ] + aVect2[wJ];
		}
	}
}

/* ========================================================================== */
/* Fonction vectorisé d'addition de deux petits vecteurs de doubles */
void addVect_sdVect(t_sdVect aVect1, t_sdVect aVect2, t_sdVect aVect3){
	int wI,wJ;
	__m128d wV1, wV2, wV3;

	for (wI=0; wI<SMALLN; wI+=SMALLN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ, wV1, wV2, wV3)
		for(wJ = wI; wJ < (wI+SMALLN/4) ; wJ+=2){
			wV1 =_mm_load_pd(&(aVect1[wJ]));
			wV2 =_mm_load_pd(&(aVect2[wJ]));
			wV3 =_mm_add_pd(wV1, wV2);
			_mm_store_pd(&(aVect3[wJ]), wV3);
		}
	}
}

/* Fonction vectorisé d'addition de deux grands vecteurs de floats */
void addVect_sfVect(t_sfVect aVect1, t_sfVect aVect2, t_sfVect aVect3){
	int wI,wJ;
	__m128 wV1, wV2, wV3;

	for (wI=0; wI<SMALLN; wI+=SMALLN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ, wV1, wV2, wV3)
		for(wJ = wI; wJ < (wI+SMALLN/4) ; wJ+=4){
			wV1 =_mm_load_ps(&(aVect1[wJ]));
			wV2 =_mm_load_ps(&(aVect2[wJ]));
			wV3 =_mm_add_ps(wV1, wV2);
			_mm_store_ps(&(aVect3[wJ]), wV3);
		}
	}
}

/* ========================================================================== */
/* Fonction multiplication d'un petit vecteur de doubles par un scalaire */
void mScalaire_sdVect(t_sdVect aVect1, double aScalaire, t_sdVect aVect2){
	int wI,wJ;
	for (wI=0; wI<SMALLN; wI+=SMALLN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+SMALLN/4) ; wJ++){
			aVect2[wJ] = aVect1[wJ] * aScalaire;
		}
	}
}

/* Fonction multiplication d'un petit vecteur de floats par un scalaire */
void mScalaire_sfVect(t_sfVect aVect1, float aScalaire, t_sfVect aVect2){
	int wI,wJ;
	for (wI=0; wI<SMALLN; wI+=SMALLN/4){
		#pragma omp parallel for firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+SMALLN/4) ; wJ++){
			aVect2[wJ] = aVect1[wJ] * aScalaire;
		}
	}
}

/* ========================================================================== */
/* Fonction produit scalaire de deux petits vecteurs de doubles */
double pScalaire_sdVect(t_sdVect aVect1, t_sdVect aVect2){
	double wReturned = 0;
	int wI,wJ;
	for (wI=0; wI<SMALLN; wI+=SMALLN/4){
		#pragma omp parallel for reduction(+:wReturned) firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+SMALLN/4) ; wJ++){
			wReturned += aVect1[wJ]*aVect2[wJ];
		}
	}
	return wReturned;
}

/* Fonction produit scalaire de deux petits vecteurs de floats */
float pScalaire_sfVect(t_sfVect aVect1, t_sfVect aVect2){
	float wReturned = 0;
	int wI,wJ;
	for (wI=0; wI<SMALLN; wI+=SMALLN/4){
		#pragma omp parallel for reduction(+:wReturned) firstprivate(wI) private(wJ)
		for(wJ = wI; wJ < (wI+SMALLN/4) ; wJ++){
			wReturned += aVect1[wJ]*aVect2[wJ];
		}
	}
	return wReturned;
}

/* ========================================================================== */
/* Fonction vectoisé produit scalaire de deux petits vecteurs de doubles */
double pScalaireVect_sdVect(t_sdVect aVect1, t_sdVect aVect2){
	__m128d wV1, wV2, wRes;
	double wReturned = 0;
	int wI,wJ;
	for (wI=0; wI<SMALLN; wI+=SMALLN/4){
		#pragma omp parallel for reduction(+:wReturned) firstprivate(wI) private(wJ, wV1, wV2, wRes)
		for(wJ = wI; wJ < (wI+SMALLN/4) ; wJ+=2){
			wV1 =_mm_load_pd(&(aVect1[wJ]));
			wV2 =_mm_load_pd(&(aVect2[wJ]));
			wRes = _mm_dp_pd(wV1, wV2, 0xFF);

			wReturned += wRes[0];
		}
	}
	return wReturned;
}

/* Fonction vectoisé produit scalaire de deux petits vecteurs de floats */
float pScalaireVect_sfVect(t_sfVect aVect1, t_sfVect aVect2){
	__m128 wV1, wV2, wRes;
	double wReturned = 0;
	int wI,wJ;
	for (wI=0; wI<SMALLN; wI+=SMALLN/4){
		#pragma omp parallel for reduction(+:wReturned) firstprivate(wI) private(wJ, wV1, wV2, wRes)
		for(wJ = wI; wJ < (wI+SMALLN/4) ; wJ+=4){
			wV1 =_mm_load_ps(&(aVect1[wJ]));
			wV2 =_mm_load_ps(&(aVect2[wJ]));
			wRes = _mm_dp_ps(wV1, wV2, 0xFF);

			wReturned += wRes[0];
		}
	}
	return wReturned;
}


/* ========================================================================== */
/* Fonction de lecture d'un vecteur de type t_sdVect */
void read_sdVect(t_sdVect aVect){
	int wJ;

	for(wJ = 0; wJ < SMALLN ; wJ++){
		scanf("%lf", &aVect[wJ]);
	}
}

/* Fonction de lecture d'un vecteur de type t_sfVect */
void read_sfVect(t_sfVect aVect){
	int wJ;
	for(wJ = 0; wJ < SMALLN ; wJ++){
		scanf("%f", &aVect[wJ]);
	}
}

/* ========================================================================== */
/* Fonction d'écriture d'un vecteur de type t_sdVect */
void write_sdVect(t_sdVect aVect){
	int wI;
	for(wI = 0; wI < SMALLN ; wI++){
		fprintf(stdout, "%f\n", aVect[wI]);
	}
}

/* Fonction d'écriture d'un vecteur de type t_sfVect */
void write_sfVect(t_sfVect aVect){
	int wI;
	for(wI = 0; wI < SMALLN ; wI++){
		fprintf(stdout, "%f\n", aVect[wI]);
	}
}
