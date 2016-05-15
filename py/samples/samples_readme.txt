我们将样本分批次从数据库导入，在文件名后面有数字表明批次。
而tr_d_s是重采样后的样本，已经作了合并。

-----------------0-------------------
tr_features = [f0, 
	[s2+'_feature_buy_location','User_Location_count'],
	[s2+'_feature_buy_merchant','User_Merchant_count'],
	[s2+'_feature_buy_merchant_location','User_Merchant_Location_count'],
	[s2+'_feature_location_buy_count','Location_buy_count'],
	[s2+'_feature_location_merchant_count','Location_Merchant_count'],
	[s2+'_feature_location_user_count','Location_User_count'],
	[s2+'_feature_merchant_buy_count','Merchant_buy_count'],
	[s2+'_feature_merchant_location_buy_count','Merchant_Location_count'],
	[s2+'_feature_merchant_location_count','Merchant_Location_count'],
	[s2+'_feature_merchant_location_user_count','Merchant_Location_User_count'],
	[s2+'_feature_merchant_user_count','Merchant_User_count'],
	[s2+'_feature_user_buy_count','User_buy_count'],
	[s2+'_feature_user_location_count','User_Location_count'],
	[s2+'_feature_user_merchant_count','User_Merchant_count'],
	[s2+'_feature_taobao_user_click','Taobao_User_Click_count','Taobao_User_Buy_count'],
]
