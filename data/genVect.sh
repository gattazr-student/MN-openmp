#!/bin/sh

# argument 1 : nom du fichier produit
# argument 2 : valeur des composantes
# argument 3 : nombre de ligne
# argument 3 : nombre de colonnes


wFileName=$1
wValue=$2
wNumberOfLines=$3
wNumberOfCols=$4

wLine=$wValue
if [ ! -z $4 ] ;then
	for wI in $(seq 2 $wNumberOfCols); do
		wLine="$wLine $wValue"
	done
fi


echo $wLine > $wFileName

# make a test file
for wI in $(seq 2 $wNumberOfLines); do
    echo $wLine >> $wFileName
done
