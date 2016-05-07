-- generate features:
-- -- tmp1: (User_id,Location_id,User_Location_count)表示用户买过Location的次数
-- -- train_feature_buy_merchant: (User_id,Location_id,Merchant_id,User_Merchant_count:默认为0)


create table tmp1 as(
select User_id, Location_id, count(*) as count
from train_before_10
group by User_id, Location_id
);
create index tmp1_User_Location on tmp1(User_id,Location_id);

create table train_feature_buy_location(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as User_Location_count
from tr_d_new as A left join tmp1 as B on 
A.User_id=B.User_id and A.Location_id=B.Location_id
);

drop table tmp1;

create index idx_feature_buy_location on train_feature_buy_location(User_id,Location_id,Merchant_id);