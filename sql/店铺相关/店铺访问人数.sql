select Merchant_id, Location_id, count(*) as num 
from ijcai2016_koubei_train 
group by Merchant_id, Location_id order by num desc; 