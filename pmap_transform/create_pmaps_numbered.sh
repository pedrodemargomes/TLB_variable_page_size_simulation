#!/bin/bash

if $# -ne 1
	echo "numero errado de parametros"
	echo "./create_pmaps_numbered.sh numero_de_pmaps"
	exit
fi

echo -n "" > pmaps.txt
for i in {0..$1}
do
	file="pmap-${i}.txt"
	while IFS= read -r line
	do
		printf '%s %d\n' "$line" $i >> pmaps.txt
	done <"$file"

done
