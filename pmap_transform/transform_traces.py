import humanfriendly
import gzip
import io
import sys
import ast

if len(sys.argv) != 3:
	print "Numero errado de argumentos"
	print "python transform_traces.py pmaps_tratados.txt tracefile-trace-00000.txt.gz"
	exit(-1)

def newSegValue(old_seg, list_seg):
    for i in list_seg:
        if (old_seg-i[7] < 0):
			return 0
        if (old_seg-i[7] < i[8]): 
			return old_seg + i[5]

list_seg = []
with open(sys.argv[1], 'r') as f:
    for line in f:
        list_seg.append( ast.literal_eval(line) )

for i in list_seg:
	i[7] = int(i[7],16)
	i[8] = humanfriendly.parse_size(i[8], binary=True)

with io.TextIOWrapper(io.BufferedReader(gzip.open(sys.argv[2]))) as file:
    for line in file:
        # print hex(int(line.split(",")[2])) + line.split(",")[1]
        print hex(newSegValue(int(line.split(",")[1],16), list_seg))[2:]

