#! /usr/bin/python
import numpy
import datetime
from sklearn import linear_model
from sklearn.externals import joblib

starttime = datetime.datetime.now()
print 'train and predict ...\n'
tr_d = numpy.load('tr_d.npy')
va_d = numpy.load('va_d.npy')

clf = linear_model.SGDClassifier()
clf.fit(tr_d[:,4:], tr_d[:,3])

joblib.dump(clf, "model.m")

p = clf.predict(va_d[:,4:])

va_r = numpy.concatenate((va_d,p.reshape(p.shape[0],1)),axis=1)

#tmp0 = va_r[numpy.where(va_r[:,-1]==1)]
#tmp = va_r[numpy.where(va_r[:,3]==1)]
#tmp2 = tmp[numpy.where(tmp[:,-1]==1)]
#print 'precision: ' + str(float(tmp2.shape[0])/float(tmp0.shape[0]))
#print 'recall: ' + str(float(tmp2.shape[0])/float(tmp.shape[0]))

#for item in va_r:
#	print str(item[3]) + ' ' + str(item[-1])

endtime1 = datetime.datetime.now()
print str((endtime1 - starttime).seconds) + ' seconds used.\n'


print 'calculate score ...\n'
me_l = numpy.load('merchants.npy')

fz = 0
fm_p = 0
fm_r = 0
for m_b in me_l:
	m = m_b[0]
	b = m_b[1]

	i_m = numpy.where(va_r[:,2]==m)
	r_m = va_r[i_m]

	i_s = numpy.where(r_m[:,3]==1)
	r_s = r_m[i_s]

	i_sb = numpy.where(r_m[:,-1]==1)
	r_sb = r_m[i_sb]

	i_s_sb = numpy.where(r_sb[:,3]==1)
	r_s_sb = r_sb[i_s_sb]
	
#	print str(min(r_s_sb.shape[0],b)) + ': ' + str(r_sb.shape[0])
	fz += min(r_s_sb.shape[0],b)
	fm_p += r_sb.shape[0]
	fm_r += min(r_s.shape[0],b)

P = float(fz)/float(fm_p)
print 'P: ' + str(P) + '\n'

R = float(fz)/float(fm_r)
print 'R: ' + str(R) + '\n'

F = (2*P*R)/(P+R)
print 'F: ' + str(F) + '\n'

endtime2 = datetime.datetime.now()
print str((endtime2 - endtime1).seconds) + ' seconds used.\n'
