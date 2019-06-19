import humanfriendly
import sys
import ast

def nextPowerOf2(n): 
	n -= 1
	n |= n >> 1
	n |= n >> 2
	n |= n >> 4
	n |= n >> 8
	n |= n >> 16
	n += 1
	return n 

f = open(sys.argv[1], "r")
list_pmap_with_desloc = []
for x in f:
    aux = ast.literal_eval(x)
    aux[0] = int(aux[0],16)
    aux[1] = nextPowerOf2(humanfriendly.parse_size(aux[1], binary=True))
    list_pmap_with_desloc.append(aux)

# Get first
aux = list_pmap_with_desloc[0]
# Offset always zero
aux.append(0)
# Skip first
iter_list = iter(list_pmap_with_desloc)
next(iter_list)
# Iterate
for i in iter_list:
    if aux[0]+aux[1] > i[0]:
        i.append(aux[0]+aux[1]-i[0])
        print "Tem de deslocar " + str(aux[0]+aux[1]-i[0])
    else:
        i.append(0)
    aux = i

for i in range(1, len(list_pmap_with_desloc)):
    for j in range(i, len(list_pmap_with_desloc)):
        list_pmap_with_desloc[j][0] += list_pmap_with_desloc[i][5]

print list_pmap_with_desloc

# Get first
aux = list_pmap_with_desloc[0]
# Skip first
iter_list = iter(list_pmap_with_desloc)
next(iter_list)
# Iterate
for i in iter_list:
    if aux[0]+aux[1] > i[0]:
        print "Tem de deslocar " + str(aux[0]+aux[1]-i[0])
    aux = i
