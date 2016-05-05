select User_id, Merchant_id, count(*) as num 
from ijcai2016_koubei_train 
group by User_id, Merchant_id order by num desc; 