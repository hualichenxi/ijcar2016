#! /usr/bin/python

import numpy
from sklearn.lda import LDA

ty = 'click'
dim_n = 2

tr_uc = numpy.load('train_user_cate_'+ty)
te_uc = numpy.load('test_user_cate_'+ty)

lda = LDA(n_components = dim_n)
lda.fit(tr_uc[:,2:], tr_uc[:,1])

tr_x = lda.transform(tr_uc[:,2:])
te_x = lda.transform(te_uc[:,1:])

tr_uc_d = numpy.concatenate((tr_uc[:,0],tr_x),axis=1)
te_uc_d = numpy.concatenate((te_uc[:,0],te_x),axis=1)

tr_d = numpy.load('../samples/tr_d0.npy')
te_d = numpy.load('../samples/te_d0.npy')

tr_uc_d2 = array_merge(tr_uc_d,tr_d)
te_uc_d2 = array_merge(te_uc_d,tr_d)


numpy.save('../sample2/tr_d_uc_'+ty,tr_ud_d2)
numpy.save('../sample2/te_d_uc_'+ty,te_ud_d2)


# d2 left join d1 on d2[0] = d1[0], d1 and d2 are sorted by [0]
def array_merge(d1,d2):
	d1_tmp = numpy.zeros((1,dim_n)) 
	i=0
	for t1 in d1:
		for t2 in d2[i:,:]:
			if t2[0]==t1[0]:
				d1_tmp = numpy.concatenate((d1_tmp,t1[1:].reshape(1,dim_n)),axis=0)
				i = i + 1
			else:
				break
	return d1_tmp[1:,:]
