#! /usr/bin/python
import numpy
import datetime
from sklearn import linear_model
from sklearn.externals import joblib

starttime = datetime.datetime.now()
print 'train ...\n'
tr_d = numpy.load('va_d.npy')

clf = linear_model.SGDClassifier()
clf.fit(tr_d[:,4:], tr_d[:,3])

joblib.dump(clf, "model.m")


endtime1 = datetime.datetime.now()
print str((endtime1 - starttime).seconds) + ' seconds used.\n'
