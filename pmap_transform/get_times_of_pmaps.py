import sys

def cmp(a,b):
	if a[0] > b[0]:
		return 1
	if a[0] < b[0]:
		return -1
	if a[2] > b[2]:
		return 1
	if a[2] < b[2]:
		return -1
	if int(a[4]) > int(b[4]):
		return 1
	if int(a[4]) < int(b[4]):
		return -1

if len(sys.argv) != 2:
	print "Numero errado de parametros"
	print "python get_times_of_pmaps.py pmaps.txt"
	exit(-1)

f = open(sys.argv[1], "r")
list_pmap_orig = []
for x in f:
	list_pmap_orig.append(filter(lambda a: a != "[" and a != "]", x.split()))

list_pmap_orig.sort(cmp=cmp)


#for i in list_pmap_orig:
#	print i

#print "\n+++++++++++++++++++++++\n"

list_pmap_mod = []
init = list_pmap_orig[0]
for i in list_pmap_orig:
	if i[0] != init[0] or i[2] != init[2]:
		aux[4] = str(init[4]) + " " + str(aux[4])
		list_pmap_mod.append(list(aux))
		init = i
	aux = i

for i in list_pmap_mod:
	print i
