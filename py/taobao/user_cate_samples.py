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

print 'get data ...'
sql = 'select A.User_id,A.Category_id,A.total_count,B.Label from train_user_cate_click_3days A inner join tr_d_new B on A.User_id = B.User_id'
cur = conn.cursor()
cur.execute(sql)
res = cur.fetchall()
arr = numpy.array(res)
res.close()

print 'transform data ...'
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
	a[Category_id-1+2] = a[Category_id-1+2] + item[2] 
	u_cate[user_id] = a

user_ids = u_cate.keys()
u = user_ids[0]
a = u_cate[u]
d = a.reshape((1,cate_n+2))
for u in user_ids[1:]:
	a = u_cate[u]
	d = numpy.concatenate((d,a.reshape(1,cate_n+2)),axis=0)

print 'save data...'
numpy.save('user_label_cate_click',d)
