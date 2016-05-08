-- generate features:
-- -- tmp1: (Merchant_id,Location_id,User_count)表示商家在某位置的总人数（不同user_id）
-- -- train_feature_merchant_location_user_count: (User_id,Location_id,Merchant_id,Merchant_Location_User_count:默认为0)


create table tmp1 as(
select Merchant_id, Location_id, count(distinct User_id) as count
from train_before_10
group by Merchant_id, Location_id
);
create index tmp1_Merchant_Location on tmp1(Merchant_id,Location_id);

create table train_feature_merchant_location_user_count(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Merchant_Location_User_count
from tr_d_new as A left join tmp1 as B on 
A.Merchant_id=B.Merchant_id and A.Location_id=B.Location_id
);

drop table tmp1;