-- use ijcai;

-- create table train_feature_buy_merchant_location_if as(
-- select User_id,Location_id,Merchant_id, IF(User_Merchant_Location_count>0,1,0) as User_Merchant_Location_if
-- from train_feature_buy_merchant_location
-- );
-- create index idx_feature_buy_merchant_location_if on train_feature_buy_merchant_location_if(User_id,Location_id,Merchant_id);

create table valid_feature_buy_merchant_location_if as(
select User_id,Location_id,Merchant_id, IF(User_Merchant_Location_count>0,1,0) as User_Merchant_Location_if
from valid_feature_buy_merchant_location
);
create index idx_valid_feature_buy_merchant_location_if 
	on valid_feature_buy_merchant_location_if(User_id,Location_id,Merchant_id);