#! /usr/bin/python

f = open('train_test_join.csv','r')
lines = f.readlines()
f.close()
res = {}

for line in lines:
	line = line.strip()
	tmp = line.split(',')
	key = tmp[0] + ',' + tmp[1]
	if res.has_key(key):
		arr = res[key]
		if tmp[2] != '\N' and tmp[2] not in arr:
			arr.append(tmp[2])
			res[key] = arr	
	else:
		if tmp[2] == '\N':
			res[key] = []
		else:
			res[key] = [tmp[2]]

keys = res.keys()
f = open('result.csv','w')
for k in keys:
	s = ':'.join(res[k])
	f.write(k+','+s+'\n')
f.close()
