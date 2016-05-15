#! /usr/bin/python

import MySQLdb
import numpy
import sys

try:
	conn = MySQLdb.connect(host='localhost',port=3306, user='root', passwd='123456', db='ijcai')
except Exception, e:
	print e
	sys.exit()

cate_n = 72

s1 = 'tr_d'
s2 = 'train'
ty = 'click'

att = 'A.User_id,B.Category_id,B.total_count'
if s1=='tr_d':
	att = att + ',A.Label'

sql = 'select '+att+' from '+s1+'_new A left join train_user_cate_'+ty+'_3days B on A.User_id = B.User_id order by A.User_id'

print 'read data ...'
cur = conn.cursor()
cur.execute(sql)
res = cur.fetchall()
arr = numpy.array(res)
cur.close()

print 'transform data ...'
#construct a map, key = user_id，value=数组，第一个元素是user_id，第二个元素是Label，第三个元素到最后是每一个category的操作数
u_cate = {}
for item in arr:
	user_id = item[0]
	if u_cate.has_key(user_id):
		a = u_cate[user_id]
	else:
		a = numpy.zeros((cate_n+2))
		a[0] = user_id
	
	if item[3] == 1:
		a[1] = 1

	if item[1] != None:
		a[int(item[1])+1] = a[int(item[1])+1] + int(item[2])

	u_cate[user_id] = a

#把上述map传化为矩阵
user_ids = u_cate.keys()
u = user_ids[0]
a = u_cate[u]
d = a.reshape((1,cate_n+2))
for u in user_ids[1:]:
	a = u_cate[u]
	d = numpy.concatenate((d,a.reshape(1,cate_n+2)),axis=0)

print 'save data...'
numpy.save(s2+'_user_cate_'+ty,d)

conn.close()
