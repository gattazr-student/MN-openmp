#!/bin/bash

# $1 = perf command output
# $2 = fileName
# $3 = using openMp? (1 if yes)
write_csv() {
	wFunction=$(echo "$1" | head -n 1 | awk -F ": " '{print $2}')
	wOccurence=$(echo "$1" | head -n 2 | tail -n 1 | awk -F ": " '{print $2}')
	wOperations=$(echo "$1" | head -n 3 | tail -n 1 | awk -F ": " '{print $2}')
	wTime=$(echo "$1" | head -n 5 | tail -n 1 | awk -F ": " '{print $2}')
	if [ $3 -eq 1 ]; then
		wFlops=$(echo "$wOccurence*$wOperations/($wTime*$NUM_THREAD)" | bc)
	else
		wFlops=$(echo "$wOccurence*$wOperations/$wTime" | bc)
	fi

	echo "$wFunction,$wOccurence,$wOperations,$wTime,$wFlops;" >> $2
}

# $1 = fileName
# $2 = OFLAG TO use
# $3 = 1 flag -openMP a mettre
modify_OFLAGS(){

	wCFLAGS=$2
	if [ $3 -eq 1 ]; then
		wCFLAGS="$wCFLAGS -fopenmp"
	fi
	# 3 seds ? Il doit y avoir moyen de faire mieux
	sed -i "/^CFLAGS/s/-fopenmp//; /^CFLAGS/s/-O[0-3]//" $1 # supprime -fopenmp and -0*
	sed -i "s/^CFLAGS=.*$/& $wCFLAGS/" $1 # rajoute les flags à la fin de la ligne CFLAGS
	sed -i 's/\ [\ ]*/\ /g' $1 # Supprimer les espaces en trop
}

# Perfs are coming !!

# Dans ce fichier, on va appeler les programmes de tests de performances
# Le résultat des tests seront stockés dans le fichier perfs/result.txt
export omp NUM_THREAD=4 #export de la variable NUM_THREAD pour les tests avec openmp
echo -e "Tests de performances"
echo -e "Toutes les opérations effectués peuvent être assez longue.\n"
wSmallVectSize=$(grep "SMALLN" includes/vecteur.h| sed 's/\ [\ ]*/\ /g' | awk -F" " '$1=="#define" { print $3 }')
wBigVectSize=$(grep "BIGN" includes/vecteur.h| sed 's/\ [\ ]*/\ /g' | awk -F" " '$1=="#define" { print $3 }')
wSmallMatrSize=$(grep "SMALLN_MATR" includes/matrice.h| sed 's/\ [\ ]*/\ /g' | awk -F" " '$1=="#define" { print $3 }')
wBigMatrSize=$(grep "BIGN_MATR" includes/matrice.h| sed 's/\ [\ ]*/\ /g' | awk -F" " '$1=="#define" { print $3 }')

wSmallVect1=data/vect_s1
wSmallVect2=data/vect_s2
wBigVect1=data/vect_b1
wBigVect2=data/vect_b2

wSmallMatr1=data/matr_s1
wSmallMatr2=data/matr_s2
wSmallMatrVect1=data/matrVect_s1
wSmallMatrVect2=data/matrVect_s2
wBigMatr1=data/matr_b1
wBigMatr2=data/matr_b2
wBigMatrVect1=data/matrVect_b1
wBigMatrVect2=data/matrVect_b2

wOUTFILE=perfs/result.csv
wGenerator=data/genVect.sh

#Efface le fichier de résultat
rm -f $wOUTFILE

# Crée les fichiers utilisés pour les tests
echo -e "Génération des fichiers nécéssaires pour les tests.\n"

$wGenerator $wSmallVect1 "1.0" $wSmallVectSize
$wGenerator $wSmallVect2 "2.0" $wSmallVectSize
$wGenerator $wBigVect1 "1.0" $wBigVectSize
$wGenerator $wBigVect2 "2.0" $wBigVectSize

$wGenerator $wSmallMatr1 "1.0" $wSmallMatrSize $wSmallMatrSize
$wGenerator $wSmallMatr2 "2.0" $wSmallMatrSize $wSmallMatrSize
$wGenerator $wSmallMatrVect1 "3.0" $wSmallMatrSize
$wGenerator $wSmallMatrVect2 "4.0" $wSmallMatrSize

$wGenerator $wBigMatr1 "1.0" $wBigMatrSize $wBigMatrSize
$wGenerator $wBigMatr2 "2.0" $wBigMatrSize $wBigMatrSize
$wGenerator $wBigMatrVect1 "3.0" $wBigMatrSize
$wGenerator $wBigMatrVect2 "4.0" $wBigMatrSize

echo -e "Début des tests de performances :\n"

for wOpenMP in $(seq 0 0); do
	wArrayCFLAGS=(' ' '-O1' '-O2' '-O3')
	for wCFLAGS in "${wArrayCFLAGS[@]}"; do
		echo "-----------------------------------------------------------------"
		echo -n "Tests avec flags d'optimisation : \"${wCFLAGS}\" "
		wOptiFlags=$wCFLAGS
		if [ $wOpenMP -eq 0 ]; then
			wOptiFlags=$wOptiFlags" sans openMP"
			echo "sans openMP"
		else
			wOptiFlags=$wOptiFlags" avec openMP"
			echo "avec openMP"
		fi

		# modification des flags du makefile
		modify_OFLAGS "Makefile" "$wCFLAGS" "$wOpenMP"

		make mrproper_perfs mrproper_libs libs perfs 2>/dev/null >/dev/null # on clean et on recompile
		if [ $? -ne 0 ]; then
	    	echo "La compilation de la librairie et des programmes de performances s'est mal passée"
	    	exit
		fi

		echo -e "\n\nVecteurs : $wOptiFlags;" >> $wOUTFILE
		echo "1/8: Tests des petits vecteurs de doubles"
		echo -e "\tfonction 1/5"
		write_csv "$(perfs/bin/vectsd_add < <(cat $wSmallVect1 $wSmallVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 2/5"
		write_csv "$(perfs/bin/vectsd_addVect < <(cat $wSmallVect1 $wSmallVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 3/5"
		write_csv "$(perfs/bin/vectsd_mult < <(cat $wSmallVect1; echo 5.0))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 4/5"
		write_csv "$(perfs/bin/vectsd_scal < <(cat $wSmallVect1 $wSmallVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 5/5"
		write_csv "$(perfs/bin/vectsd_scalVect < <(cat $wSmallVect1 $wSmallVect2))" $wOUTFILE $wOpenMP

		echo "2/8: Tests des petits vecteurs de floats"
		echo -e "\tfonction 1/5"
		write_csv "$(perfs/bin/vectsf_add < <(cat $wSmallVect1 $wSmallVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 2/5"
		write_csv "$(perfs/bin/vectsf_addVect < <(cat $wSmallVect1 $wSmallVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 3/5"
		write_csv "$(perfs/bin/vectsf_mult < <(cat $wSmallVect1; echo 5.0))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 4/5"
		write_csv "$(perfs/bin/vectsf_scal < <(cat $wSmallVect1 $wSmallVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 5/5"
		write_csv "$(perfs/bin/vectsf_scalVect < <(cat $wSmallVect1 $wSmallVect2))" $wOUTFILE $wOpenMP

		echo "3/8: Tests des grands vecteurs de doubles"
		echo -e "\tfonction 1/5"
		write_csv "$(perfs/bin/vectbd_add < <(cat $wBigVect1 $wBigVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 2/5"
		write_csv "$(perfs/bin/vectbd_addVect < <(cat $wBigVect1 $wBigVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 3/5"
		write_csv "$(perfs/bin/vectbd_mult < <(cat $wBigVect1; echo 5.0))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 4/5"
		write_csv "$(perfs/bin/vectbd_scal < <(cat $wBigVect1 $wBigVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 5/5"
		write_csv "$(perfs/bin/vectbd_scalVect < <(cat $wBigVect1 $wBigVect2))" $wOUTFILE $wOpenMP

		echo "4/8: Tests des grands vecteurs de floats"
		echo -e "\tfonction 1/5"
		write_csv "$(perfs/bin/vectbf_add < <(cat $wBigVect1 $wBigVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 2/5"
		write_csv "$(perfs/bin/vectbf_addVect < <(cat $wBigVect1 $wBigVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 3/5"
		write_csv "$(perfs/bin/vectbf_mult < <(cat $wBigVect1; echo 5.0))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 4/5"
		write_csv "$(perfs/bin/vectbf_scal < <(cat $wBigVect1 $wBigVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 5/5"
		write_csv "$(perfs/bin/vectbf_scalVect < <(cat $wBigVect1 $wBigVect2))" $wOUTFILE $wOpenMP



		echo -e "\n\nMatrices : $wOptiFlags;" >> $wOUTFILE
		echo "5/8: Tests des petites matrices de doubles"
		echo -e "\tfonction 1/8"
		write_csv "$(perfs/bin/matrsd_add < <(cat $wSmallMatr1 $wSmallMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 2/8"
		write_csv "$(perfs/bin/matrsd_addVect < <(cat $wSmallMatr1 $wSmallMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 3/8"
		write_csv "$(perfs/bin/matrsd_factLU < <(cat $wSmallMatr1))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 4/8"
		write_csv "$(perfs/bin/matrsd_gaxpy < <(cat $wSmallMatr1 $wSmallMatrVect1 $wSmallMatrVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 5/8"
		write_csv "$(perfs/bin/matrsd_mScalaire < <(cat $wSmallMatr1; echo 5.0))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 6/8"
		write_csv "$(perfs/bin/matrsd_mult < <(cat $wSmallMatr1 $wSmallMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 7/8"
		write_csv "$(perfs/bin/matrsd_multVect < <(cat $wSmallMatr1 $wSmallMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 8/8"
		write_csv "$(perfs/bin/matrsd_transpo < <(cat $wSmallMatr1))" $wOUTFILE $wOpenMP

		echo "6/8: Tests des petites matrices de floats"
		echo -e "\tfonction 1/8"
		write_csv "$(perfs/bin/matrsf_add < <(cat $wSmallMatr1 $wSmallMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 2/8"
		write_csv "$(perfs/bin/matrsf_addVect < <(cat $wSmallMatr1 $wSmallMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 3/8"
		write_csv "$(perfs/bin/matrsf_factLU < <(cat $wSmallMatr1))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 4/8"
		write_csv "$(perfs/bin/matrsf_gaxpy < <(cat $wSmallMatr1 $wSmallMatrVect1 $wSmallMatrVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 5/8"
		write_csv "$(perfs/bin/matrsf_mScalaire < <(cat $wSmallMatr1; echo 5.0))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 6/8"
		write_csv "$(perfs/bin/matrsf_mult < <(cat $wSmallMatr1 $wSmallMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 7/8"
		write_csv "$(perfs/bin/matrsf_multVect < <(cat $wSmallMatr1 $wSmallMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 8/8"
		write_csv "$(perfs/bin/matrsf_transpo < <(cat $wSmallMatr1))" $wOUTFILE $wOpenMP

		echo "7/8: Tests des grandes matrices de doubles"
		echo -e "\tfonction 1/8"
		write_csv "$(perfs/bin/matrbd_add < <(cat $wBigMatr1 $wBigMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 2/8"
		write_csv "$(perfs/bin/matrbd_addVect < <(cat $wBigMatr1 $wBigMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 3/8"
		write_csv "$(perfs/bin/matrbd_factLU < <(cat $wBigMatr1))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 4/8"
		write_csv "$(perfs/bin/matrbd_gaxpy < <(cat $wBigMatr1 $wBigMatrVect1 $wBigMatrVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 5/8"
		write_csv "$(perfs/bin/matrbd_mScalaire < <(cat $wBigMatr1; echo 5.0))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 6/8"
		write_csv "$(perfs/bin/matrbd_mult < <(cat $wBigMatr1 $wBigMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 7/8"
		write_csv "$(perfs/bin/matrbd_multVect < <(cat $wBigMatr1 $wBigMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 8/8"
		write_csv "$(perfs/bin/matrbd_transpo < <(cat $wBigMatr1))" $wOUTFILE $wOpenMP

		echo "8/8: Tests des grandes matrices de floats"
		echo -e "\tfonction 1/8"
		write_csv "$(perfs/bin/matrbf_add < <(cat $wBigMatr1 $wBigMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 2/8"
		write_csv "$(perfs/bin/matrbf_addVect < <(cat $wBigMatr1 $wBigMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 3/8"
		write_csv "$(perfs/bin/matrbf_factLU < <(cat $wBigMatr1))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 4/8"
		write_csv "$(perfs/bin/matrbf_gaxpy < <(cat $wBigMatr1 $wBigMatrVect1 $wBigMatrVect2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 5/8"
		write_csv "$(perfs/bin/matrbf_mScalaire < <(cat $wBigMatr1; echo 5.0))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 6/8"
		write_csv "$(perfs/bin/matrbf_mult < <(cat $wBigMatr1 $wBigMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 7/8"
		write_csv "$(perfs/bin/matrbf_multVect < <(cat $wBigMatr1 $wBigMatr2))" $wOUTFILE $wOpenMP
		echo -e "\tfonction 8/8"
		write_csv "$(perfs/bin/matrbf_transpo < <(cat $wBigMatr1))" $wOUTFILE $wOpenMP
	done
done

echo "Les résultats sont dans le fichier $wOUTFILE"
