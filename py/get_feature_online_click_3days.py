#coding=utf-8
#! /usr/bin/python

import MySQLdb
import numpy
import sys


localhost = '10.214.0.95'
try:    
    conn = MySQLdb.connect(host=localhost,port=3306, user='root', passwd='123456', db='ijcai')
except Exception, e:  
    print e  
    sys.exit()

s1='tr_d_new'
s2='user_cate_click_3days'

s3="train"

print 'read %s' %(s1)
sql = 'select * from ' + s1 + ' order by User_id,Location_id,Merchant_id'
print sql
# cur = conn.cursor()
# cur.execute(sql)
# res = cur.fetchall()
# train_target = numpy.array(res)
# print "train samples: %d" %(len(train_target))
# print "shape for train samples %d * %d"%(train_target.shape)
#
# category_columns=numpy.zeros((len(train_target),72))
# train_whole = numpy.concatenate((train_target,category_columns),axis=1)
# print "shape for train whole %d * %d"%(train_whole.shape)
#
#
# print 'read %s' %(s2)
# sql = 'select * from ' + s2 + ' order by User_id,Location_id,Merchant_id'
# print sql
# cur = conn.cursor()
# cur.execute(sql)
# res = cur.fetchall()
# train_feature = numpy.array(res)
# print "train features: %d" %(len(train_feature))
# print "shape for train features %d * %d"%(train_feature.shape)
#
# for i in range(len(train_feature)):
#     user_id=train_feature[i,0]
#     category_id=train_feature[i,1]
#     count=train_feature[i,2]
#
#     #找出样本中userid相同的那些行,category_id从1到72
#     row=(train_whole[:,0]==user_id)
#     tmp=train_whole[row]
#     tmp[:,category_id+3]=count
#     train_whole[row]=tmp
#
#
# print train_whole[train_whole[:,0]==108][:,5]
#
# print 'save to file...'
# numpy.save(s3+"feature_online_click_3_days",train_whole)

cur.close()

