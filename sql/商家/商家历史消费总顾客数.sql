-- generate features:
-- -- tmp1: (Merchant_id,count)表示某商家历史消费总顾客数
-- -- train_feature_merchant_user_count: (User_id,Location_id,Merchant_id,Merchant_user_count:默认为0)


-- create table tmp1 as(
-- select Merchant_id, count(distinct User_id) as count
-- from train_before_10
-- group by Merchant_id
-- );
-- create index tmp1_Merchant on tmp1(Merchant_id);

-- create table train_feature_merchant_user_count(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Merchant_User_count
-- from tr_d_new as A left join tmp1 as B on 
-- A.Merchant_id=B.Merchant_id
-- );
-- create index idx_Merchant_User on train_feature_merchant_user_count(User_id,Merchant_id,Location_id);
-- select * from tmp1 order by count desc limit 5;
-- select * from train_feature_merchant_user_count order by Merchant_User_count desc limit 5;

-- drop table tmp1;

create table tmp1 as(
select Merchant_id, count(distinct User_id) as count
from train_before_11
group by Merchant_id
);
create index tmp1_Merchant on tmp1(Merchant_id);

create table valid_feature_merchant_user_count(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Merchant_User_count
from va_d_new as A left join tmp1 as B on 
A.Merchant_id=B.Merchant_id
);
create index idx_valid_Merchant_User on valid_feature_merchant_user_count(User_id,Merchant_id,Location_id);

select * from tmp1 order by count desc limit 5;
select * from valid_feature_merchant_user_count order by Merchant_User_count desc limit 5;

drop table tmp1;