

def cmp(a,b)
	if a[0] > b[0]
		return -1
	if a[0] < b[0]
		return 1
	if humanfriendly.parse_size(a[1]) > humanfriendly.parse_size(a[1])	
		return -1
	if humanfriendly.parse_size(a[1]) < humanfriendly.parse_size(a[1])	
		return 1


f = open("pmaps.txt", "r")
list = []
for x in f:
	list.append(filter(lambda a: a != "[" and a != "]", x.split()));

for i in list:
	print i
