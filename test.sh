#!/bin/bash

# On efface les exécutables de tests s'ils existent et on les recompile.
make clean_tests tests >/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
	echo "La compilation des programmes de tests s'est mal passé"
	exit
fi

# Dans ce fichier, on va appeler les programmes test_bdv, test_bfv, test_sdv et test_sfv
# Le résultat des tests seront affichés dans le fichier tests/result.txt
wOUTFILE=tests/result.txt

# VECTEURS :
source_vectb1="./data/vect_b1"
source_vects1="./data/vect_s1"
source_vectb2="./data/vect_b2"
source_vects2="./data/vect_s2"

# MATRICE :
source_matr_b="./data/matr_b"
source_matr_s="./data/matr_s"
source_matr_b_t1="./data/matr_b_transpo1"
source_matr_b_t2="./data/matr_b_transpo2"
source_matr_s_t1="./data/matr_s_transpo1"
source_matr_s_t2="./data/matr_s_transpo2"

#VARIBALES
valeur_ligne="1.0"
valeur_colonne="0.0"
valeur1="1.0"
valeur2="2.0"
scalaire="5.0"

#GÉNÉRATEUR
vect_gen="./data/genVect.sh"
matr_gen="./data/genMatr.sh"

BIGN_VECT=$(grep "BIGN" ./includes/vecteur.h| sed 's/\ [\ ]*/\ /g' | awk -F" " '$1=="#define" { print $3 }')
SMALLN_VECT=$(grep "SMALLN" ./includes/vecteur.h| sed 's/\ [\ ]*/\ /g' | awk -F" " '$1=="#define" { print $3 }')
BIGN_MATR=$(grep "BIGN" ./includes/matrice.h | awk -F" " '$1=="#define" { print $3 }')
SMALLN_MATR=$(grep "SMALLN" ./includes/matrice.h | awk -F" " '$1=="#define" { print $3 }')

# # on génère les fichiers d'entrée et de comparaison
# # VECTEURS :
$vect_gen $source_vectb1 $valeur1 $BIGN_VECT
$vect_gen $source_vects1 $valeur1 $SMALLN_VECT
$vect_gen $source_vectb2 $valeur2 $BIGN_VECT
$vect_gen $source_vects2 $valeur2 $SMALLN_VECT
# # MATRICES :
$vect_gen $source_matr_b $valeur1 $BIGN_MATR $BIGN_MATR
$vect_gen $source_matr_s $valeur1 $SMALLN_MATR $SMALLN_MATR
$matr_gen $source_matr_b_t1 $source_matr_b_t2 $valeur_ligne $valeur_colonne $BIGN_MATR $BIGN_MATR
$matr_gen $source_matr_s_t1 $source_matr_s_t2 $valeur_ligne $valeur_colonne $SMALLN_MATR $SMALLN_MATR


# on génère un fichier où sera stocké toutes les entrées pour les vecteurs longs
echo $valeur1 > vect_in_B
cat $source_vectb1 >> vect_in_B
echo $valeur2 >> vect_in_B
cat $source_vectb2 >> vect_in_B
echo $scalaire >> vect_in_B
echo >> vect_in_B

# on génère un fichier pour les entrées avec les vecteurs courts
echo $valeur1 > vect_in_S
cat $source_vects1 >> vect_in_S
echo $valeur2 >> vect_in_S
cat $source_vects2 >> vect_in_S
echo $scalaire >> vect_in_S
echo >> vect_in_S

# on génère un fichier d'entrée pour les grandes matrices
echo $valeur1 > matr_in_B
cat $source_matr_b >> matr_in_B
echo $scalaire >> matr_in_B
echo $valeur1 >> matr_in_B
echo $valeur2 >> matr_in_B
cat $source_matr_b_t1 >> matr_in_B

# on génère un fichier d'netrée pour les petites matrices
echo $valeur1 > matr_in_S
cat $source_matr_s >> matr_in_S
echo $scalaire >> matr_in_S
echo $valeur1 >> matr_in_S
echo $valeur2 >> matr_in_S
cat $source_matr_s_t1 >> matr_in_S

# Efface le fichier qui va contenir les résultats
rm -f tests/result.txt

# Voici les tests
if ./tests/bin/test_bdv < vect_in_B > vect_out_B 2>>$wOUTFILE
then
	echo >> vect_out_B # différence sinon entre les deux fichiers au nveau de la dernière ligne.
	sed 's/[0]*//g' vect_out_B > vect_out_B
	sed 's/[0]*//g' $source_vectb1 > $source_vectb1
	if diff $source_vectb1 vect_out_B > /dev/null
 	then
		echo "Les fonctions manipulants les grands vecteurs de doubles sont parfaites" >>$wOUTFILE
	else
		echo "Probleme pour la lecture/écriture des grands vecteurs de doubles" >>$wOUTFILE
	fi
fi
if ./tests/bin/test_bfv < vect_in_B > vect_out_B 2>>$wOUTFILE
then
	echo >> vect_out_B # différence sinon entre les deux fichiers au nveau de la dernière ligne.
	sed 's/[0]*//g' vect_out_B > vect_out_B
	sed 's/[0]*//g' $source_vectb1 > $source_vectb1
	if diff $source_vectb1 vect_out_B > /dev/null
	then
		echo "Les fonctions manipulants les grands vecteurs de flottants sont parfaites" >>$wOUTFILE
	else
		echo "Probleme pour la lecture/écriture des grands vecteurs de flottants" >>$wOUTFILE
	fi
fi
if ./tests/bin/test_sdv < vect_in_S > vect_out_S 2>>$wOUTFILE
then
	echo >> vect_out_S # différence sinon entre les deux fichiers au nveau de la dernière ligne.
	sed 's/[0]*//g' vect_out_S > vect_out_S
	sed 's/[0]*//g' $source_vects1 > $source_vects1
	if diff $source_vects1 vect_out_S > /dev/null
	then
		echo "Les fonctions manipulants les petits vecteurs de doubles sont parfaites" >>$wOUTFILE
	else
		echo "Probleme pour la lecture/écriture des petits vecteurs de doubles" >>$wOUTFILE
	fi
fi
if ./tests/bin/test_sfv < vect_in_S > vect_out_S 2>>$wOUTFILE
then
	echo >> vect_out_S # différence sinon entre les deux fichiers au nveau de la dernière ligne.
	sed 's/[0]*//g' vect_out_S > vect_out_S
	sed 's/[0]*//g' $source_vects1 > $source_vects1
	if diff $source_vects1 vect_out_S > /dev/null
	then
		echo "Les fonctions manipulants les petits vecteurs de flottants sont parfaites" >>$wOUTFILE
	else
		echo "Probleme pour la lecture/écriture des petits vecteurs de flottants" >>$wOUTFILE
	fi
fi

# crétion des fichiers de comparaison pour les matrices, sur les fonctions de lecture/ecriture et la transposition
# Grandes
	cat $source_matr_b > matr_cmp_B
	echo >> matr_cmp_B
	cat $source_matr_b_t2 >> matr_cmp_B
# Petites
	cat $source_matr_s > matr_cmp_S
	echo >> matr_cmp_S
	cat $source_matr_s_t2 >> matr_cmp_S

# Tests sur les matrices
if ./tests/bin/test_bdm < matr_in_B > matr_out_B
then
	if diff -b matr_cmp_B matr_out_B > /dev/null
	then
		echo "Les fonctions de lecture/écriture et la transposition sont pafaites (grandes doubles)" >>$wOUTFILE
	else
		echo "Probleme pour la lecture/écriture ou de la transposition des grandes matrices doubles" >>$wOUTFILE
	fi
fi
if ./tests/bin/test_bfm < matr_in_B > matr_out_B
then
	if diff -b matr_cmp_B matr_out_B > /dev/null
	then
		echo "Les fonctions de lecture/écriture et la transposition sont parfaites (grandes flottantes" >>$wOUTFILE
	else
		echo "Probleme pour la lecture/écriture ou de la transposition des grandes matrices flottantes" >>$wOUTFILE
	fi
fi
if ./tests/bin/test_sdm < matr_in_S > matr_out_S
then
	if diff -b matr_cmp_S matr_out_S > /dev/null
	then
		echo "Les fonctions de lecture/écriture et la transposition sont parfaites (petites doubles)" >>$wOUTFILE
	else
		echo "Probleme pour la lecture/écriture ou de la transposition des petites matrices doubles" >>$wOUTFILE
	fi
fi
if ./tests/bin/test_sfm < matr_in_S > matr_out_S
then
	if diff -b matr_cmp_S matr_out_S > /dev/null
	then
		echo "Les fonctions de lecture/écriture et la transposition sont parfaites (petites flottantes)" >>$wOUTFILE
	else
		echo "Probleme pour la lecture/écriture ou de la transposition des petites matrices flottantes" >>$wOUTFILE
	fi
fi

# terminal-notifier -message "DONE" #-> MAC OS
# notify-send "DONE" -> DEBIAN

rm -f vect_in_B vect_out_B vect_in_S vect_out_S matr_in_B matr_in_S matr_out_B matr_out_S matr_cmp_S matr_cmp_B
echo "Le résultat des tests de fonctionalités se trouvent dans le fichier $wOUTFILE"
