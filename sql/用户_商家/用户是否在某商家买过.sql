use ijcai;

create table train_feature_buy_merchant_if as(
select User_id,Location_id,Merchant_id, IF(User_Merchant_count>0,1,0) as User_Merchant_if
from train_feature_buy_merchant
);
create index idx_feature_buy_merchant_if on train_feature_buy_merchant_if(User_id,Location_id,Merchant_id);