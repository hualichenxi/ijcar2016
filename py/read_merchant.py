#! /usr/bin/python

import MySQLdb
import numpy
import sys
localhost = '10.214.0.95'
try:    
	conn = MySQLdb.connect(host=localhost, port=3306, user='bc', passwd='123456', db='ijcai')  
except Exception, e:  
    print e  
    sys.exit()  

print 'read from mysql...'
sql = 'select distinct Merchant_id,Budget from ijcai2016_merchant_info'
cur = conn.cursor()
cur.execute(sql)
res = cur.fetchall()
arr = numpy.array(res)
cur.close()

conn.close()

print 'save data...'
numpy.save('merchants',arr)
