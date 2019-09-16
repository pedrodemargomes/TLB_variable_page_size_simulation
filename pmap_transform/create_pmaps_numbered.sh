#!/bin/bash

if [ "$#" -ne 1 ]
then
	echo "numero errado de parametros"
	echo "./create_pmaps_numbered.sh numero_de_pmaps"
	exit 1
fi

echo -n "" > pmaps.txt
for i in $(seq 0 $1)
do
	echo $i
	file="pmap-${i}.txt"
	while IFS= read -r line
	do
		printf '%s %d\n' "$line" $i >> pmaps.txt
	done <"$file"

done
