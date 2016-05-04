use ijcai;
create table train_test_join(
select ijcai2016_koubei_test.User_id,ijcai2016_koubei_test.Location_id,Merchant_id 
from ijcai2016_koubei_train right join ijcai2016_koubei_test 
on ijcai2016_koubei_train.User_id = ijcai2016_koubei_test.User_id 
and ijcai2016_koubei_train.Location_id = ijcai2016_koubei_test.Location_id
);