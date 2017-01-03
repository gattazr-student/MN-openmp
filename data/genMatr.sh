#!/bin/sh

# argument 1 : nom du fichier produit ligne1 = valeur1 ligne2 = valeur2
# argument 2 : nom du fichier 2ieme produit colonne1 = valeur1 colonne2 = valeur2
# argument 3 : valeur1
# argument 4 : valeur2
# argument 5 : nombre de ligne
# argument 6 : nombre de colonnes

#script shell bash
wFileName1=$1
wFileName2=$2
wValue1=$3
wValue2=$4
wNumberOfLines=$5
wNumberOfCols=$6

#1er fichier
for wI in $(seq 1 $wNumberOfCols)
do
	wLine1="$wLine1 $wValue1"
done

for wI in $(seq 1 $wNumberOfCols)
do
	wLine2="$wLine2 $wValue2"
done

#ecriture
echo $wLine1 > $wFileName1

for wI in $(seq 2 $wNumberOfLines)
do
	if [ $((wI % 2)) -eq 1 ]
	then
		echo $wLine1 >> $wFileName1
	else
		echo $wLine2 >> $wFileName1
	fi
done

#2ieme fichier
for wI in $(seq 1 $wNumberOfCols)
do
	if [ $((wI % 2)) -eq 1 ]
		then
		wLine3="$wLine3 $wValue1"
	else
		wLine3="$wLine3 $wValue2"
	fi
done

#ecriture
echo $wLine3 > $wFileName2

for wI in $(seq 2 $wNumberOfLines)
do
	echo $wLine3 >> $wFileName2
done

