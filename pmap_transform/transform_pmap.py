import humanfriendly
import sys

def nextPowerOf2(n): 
	n -= 1
	n |= n >> 1
	n |= n >> 2
	n |= n >> 4
	n |= n >> 8
	n |= n >> 16
	n += 1
	return n 
  
def cmpN(a,b):
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


def cmp(a,b):
	if a[0] > b[0]:
		return 1
	if a[0] < b[0]:
		return -1
	if a[2] > b[2]:
		return 1
	if a[2] < b[2]:
		return -1
	if humanfriendly.parse_size(a[1], binary=True) > humanfriendly.parse_size(b[1], binary=True):
		return 1
	if humanfriendly.parse_size(a[1], binary=True) < humanfriendly.parse_size(b[1], binary=True):	
		return -1
	return -1


f = open(sys.argv[1], "r")
list_pmap_orig = []
for x in f:
	list_pmap_orig.append(filter(lambda a: a != "[" and a != "]", x.split()))

list_pmap_orig.sort(cmp=cmpN)

list_pmap_mod = []
init = list_pmap_orig[0]
for i in list_pmap_orig:
	if i[0] != init[0] or i[2] != init[2]:
		aux[4] = str(init[4]) + " " + str(aux[4])
		list_pmap_mod.append(list(aux))
		init = i
	aux = i

list_pmap_orig = list(list_pmap_mod)

list_pmap_mod = []
list_pmap_mod.append(list_pmap_orig[0])
for i in list_pmap_orig:
	if i[0] == list_pmap_mod[-1][0] and i[2] == list_pmap_mod[-1][2]:
		if humanfriendly.parse_size(list_pmap_mod[-1][1], binary=True) < humanfriendly.parse_size(i[1], binary=True):
			list_pmap_mod[-1][1] = i[1]
	else:
		list_pmap_mod.append(i)

print "\n\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n"

i = 1
while i < len(list_pmap_mod):
	if(list_pmap_mod[i][0] == list_pmap_mod[i-1][0]):
		if(humanfriendly.parse_size(list_pmap_mod[i][1], binary=True) > humanfriendly.parse_size(list_pmap_mod[i-1][1], binary=True)):
			del list_pmap_mod[i-1]
		else:
			del list_pmap_mod[i]
	else:
		i += 1

i = 1
while i < len(list_pmap_mod):
	if(humanfriendly.parse_size(list_pmap_mod[i-1][1], binary=True) + int(list_pmap_mod[i-1][0], 16) > int(list_pmap_mod[i][0], 16) ):
		del list_pmap_mod[i]
	else:
		i += 1 

for i in list_pmap_mod:
	i[1] = humanfriendly.format_size(nextPowerOf2(humanfriendly.parse_size(i[1], binary=True)), binary=True) 

aux = []
aux.append(0)
aux.append(0)
for i in list_pmap_mod:
	print i
	if aux[0] > int(i[0],16):
		print "[ERRO]: " + str(aux[1]) + " PASSOU: " + str(hex(aux[0]))
		i.append(str(hex(aux[0])))
	aux[0] = int(i[0], 16) + humanfriendly.parse_size(i[1], binary=True)
	aux[1] = i[0]










