import sys
import ast

if len(sys.argv) != 2:
	print "Numero errado de argumentos"
	print "python clean_pmap.py pmaps_tratados.txt"
	exit(-1)

list_pmap = []
with open(sys.argv[1], 'r') as f:
	for line in f:
		list_pmap.append( ast.literal_eval(line) )

for i in list_pmap:
	print i[0][2:]+" "+i[6][2:]+" 0000000000000000"


