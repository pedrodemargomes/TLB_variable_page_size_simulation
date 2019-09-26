#!/bin/bash
for i in $(seq 0 2000)
do
	echo "tracefile-trace-${i}_tratados.txt"
	cat "tracefile-trace-${i}_tratados.txt" >> all_transformed_tracefiles_tratados.txt
done
