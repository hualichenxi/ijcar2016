select Location_id, count(*) as num 
from ijcai2016_koubei_train 
group by Location_id order by num desc; 