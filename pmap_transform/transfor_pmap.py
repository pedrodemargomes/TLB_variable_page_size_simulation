import humanfriendly

def nextPowerOf2(n): 
	n -= 1
	n |= n >> 1
	n |= n >> 2
	n |= n >> 4
	n |= n >> 8
	n |= n >> 16
	n += 1
	return n 
  

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


f = open("pmaps.txt", "r")
list_pmap_orig = []
for x in f:
	list_pmap_orig.append(filter(lambda a: a != "[" and a != "]", x.split()))

list_pmap_orig.sort(cmp=cmp)

for i in list_pmap_orig:
	print i

list_pmap_mod = []
list_pmap_mod.append(list_pmap_orig[0])
for i in list_pmap_orig:
	if i[0] == list_pmap_mod[-1][0] and i[2] == list_pmap_mod[-1][2]:
		if humanfriendly.parse_size(list_pmap_mod[-1][1], binary=True) < humanfriendly.parse_size(i[1], binary=True):
			list_pmap_mod[-1][1] = i[1]
	else:
		list_pmap_mod.append(i)


print "\n\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n"

for i in list_pmap_mod:
	print i

aux = []
aux.append(0)
aux.append(0)
for i in list_pmap_mod:
	if aux[0] > int(i[0],16) and aux[1] != i[0]:
		print "[ERRO]: " + str(i) 
	aux[0] = int(i[0], 16) + humanfriendly.parse_size(i[1], binary=True)
	aux[1] = i[0]
