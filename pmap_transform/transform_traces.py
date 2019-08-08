import humanfriendly
import gzip
import io
import sys

with io.TextIOWrapper(io.BufferedReader(gzip.open(sys.argv[1]))) as file:
    for line in file:
        print hex(int(line.split(",")[2])) + line.split(",")[1]