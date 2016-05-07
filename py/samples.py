#! /usr/bin/python

import MySQLdb
import numpy
import sys

try:    
	conn = MySQLdb.connect(host='localhost',port=3306, user='root', passwd='123456', db='ijcai')  
except Exception, e:  
    print e  
    sys.exit()  



features = [ 
	['tr_d_new','User_id','Location_id','Merchant_id','Label'],
	['train_feature_buy_location','User_Location_count'],
	['train_feature_buy_merchant','User_Merchant_count'],
	['train_feature_buy_merchant_location','User_Merchant_Location_count']
]


arrs = []
for feature in features:
	table = feature[0]
	atts = ','.join(feature[1:])
	sql = 'select ' + atts + ' from ' + table + ' order by User_id,Location_id,Merchant_id'
	print sql
	cur = conn.cursor()
	cur.execute(sql)
	res = cur.fetchall()
	arr = numpy.array(res)
	arrs.append(arr)
	cur.close()

print 'array merge...'
tr_d = numpy.array(arrs[0])
for arr in arrs[1:]:
	tr_d = numpy.concatenate((tr_d,arr),axis=1)

print 'save to file...'
numpy.save('tr_d',tr_d)

conn.close()
