#!/bin/bash

for i in $(seq 0 2000)
do 
	x=$(printf "%05d" $i)
	echo "tracefile-trace-${x}.txt.zip"
	python ~/tlb/pmap_transform/transform_traces.py pmaps/pmaps_tratados.txt tracefile-trace-${x}.txt.zip > tracefile-trace-${i}_tratados.txt
done
