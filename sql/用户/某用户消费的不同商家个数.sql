-- generate features:
-- -- tmp1: (User_id,count)表示某用户消费商家个数(不同商家)
-- -- train_feature_user_merchant_count: (User_id,Location_id,Merchant_id,user_merchant_count:默认为0)


-- create table tmp1 as(
-- select User_id, count(distinct Merchant_id) as count
-- from train_before_10
-- group by User_id
-- );
-- create index tmp1_User on tmp1(User_id);

-- create table train_feature_user_merchant_count(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as User_Merchant_count
-- from tr_d_new as A left join tmp1 as B on 
-- A.User_id=B.User_id
-- );

-- create index idx_User_Merchant on train_feature_user_merchant_count(User_id,Merchant_id,Location_id);
-- select * from tmp1 order by count desc limit 5;
-- select * from train_feature_user_merchant_count order by User_Merchant_count desc limit 5;

-- drop table tmp1;

create table tmp1 as(
select User_id, count(distinct Merchant_id) as count
from train_before_11
group by User_id
);
create index tmp1_User on tmp1(User_id);

create table valid_feature_user_merchant_count(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as User_Merchant_count
from va_d_new as A left join tmp1 as B on 
A.User_id=B.User_id
);

create index idx_valid_User_Merchant on valid_feature_user_merchant_count(User_id,Merchant_id,Location_id);
select * from tmp1 order by count desc limit 5;
select * from valid_feature_user_merchant_count order by User_Merchant_count desc limit 5;

drop table tmp1;