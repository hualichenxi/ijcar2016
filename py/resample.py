#! /usr/bin/python
import numpy

s1 = 'tr_d'

d = numpy.load(s1+'.npy')

d0 = d[numpy.where(d[:,3]==0)]
numpy.random.shuffle(d0)
n0 = d0.shape[0]
d0_s = d0[0:n0/3,:]

d1 = d[numpy.where(d[:,3]==1)]
d1_s = numpy.concatenate((d1,d1,d1),axis=0)

print 'Positive #: ' + str(d1_s.shape[0])
print 'Negative #: ' + str(d0_s.shape[0])

d_s = numpy.concatenate((d0_s,d1_s),axis=0)
numpy.random.shuffle(d_s)

print 'save file...'
numpy.save(s1+'_s',d_s)

