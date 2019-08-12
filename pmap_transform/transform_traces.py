import humanfriendly
import gzip
import io
import sys
import ast

def newSegValue(old_seg, list_seg):
    for i in list_seg:
        if old_seg-int(i[7],16) < humanfriendly.parse_size(i[8], binary=True): 
            return old_seg + i[5]

list_seg = []
with open(sys.argv[1], 'r') as f:
    for line in f:
        list_seg.append( ast.literal_eval(line) )

with io.TextIOWrapper(io.BufferedReader(gzip.open(sys.argv[2]))) as file:
    for line in file:
        # print hex(int(line.split(",")[2])) + line.split(",")[1]
        print hex(newSegValue(int(line.split(",")[1],16), list_seg))
