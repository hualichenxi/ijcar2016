select count(distinct t1.User_id,t1.Location_id,t2.Merchant_id) 
from train t1, ijcai2016_merchant_info t2 where
t1.Location_id=t2.Location_id
and  t1.Merchant_id!=t2.Merchant_id;