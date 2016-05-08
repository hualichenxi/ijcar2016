-- generate features:
-- -- train_before_10: (User_id,Merchant_id,Location_id,Time_Stamp) in koubei_train from July 1st to Sep 30th
-- -- tmp1: (User_id,Merchant_id,User_Merchant_count)表示用户买过merchant的次数
-- -- train_feature_buy_merchant: (User_id,Location_id,Merchant_id,User_Merchant_count:默认为0)

-- create table if not exists train_before_10 as(
-- select * from ijcai2016_koubei_train 
-- where Time_Stamp<"2015-10-01 00:00:00" 
-- );

-- create table tmp1 as(
-- select User_id, Merchant_id, count(*) as User_Merchant_count
-- from train_before_10
-- group by User_id, Merchant_id
-- );
-- create index tmp1_User_id_Merchant_id on tmp1(User_id,Merchant_id)
-- 
-- create table train_feature_buy_merchant(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.User_Merchant_count,0) 
-- as User_Merchant_count from tr_d_new as A left join tmp1 as B on 
-- A.User_id=B.User_id and A.Merchant_id=B.Merchant_id
-- );
-- 
-- drop tmp1;
-- 
-- create index idx_feature_buy_merchant on train_feature_buy_merchant(User_id,Location_id,Merchant_id);
-- 
-- 

create table tmp1 as(
select User_id, Merchant_id, count(*) as User_Merchant_count
from train_before_11
group by User_id, Merchant_id
);
create index tmp1_User_id_Merchant_id on tmp1(User_id,Merchant_id);

create table valid_feature_buy_merchant(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.User_Merchant_count,0) 
as User_Merchant_count from va_d_new as A left join tmp1 as B on 
A.User_id=B.User_id and A.Merchant_id=B.Merchant_id
);

drop table tmp1;

create index idx_feature_buy_merchant on valid_feature_buy_merchant(User_id,Location_id,Merchant_id);





