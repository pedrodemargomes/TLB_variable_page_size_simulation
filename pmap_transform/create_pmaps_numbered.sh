#!/bin/bash

echo -n "" > pmaps.txt
for i in {0..98}
do
	file="pmap-${i}.txt"
	while IFS= read -r line
	do
		printf '%s %d\n' "$line" $i >> pmaps.txt
	done <"$file"

done
