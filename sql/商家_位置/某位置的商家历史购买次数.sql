-- generate features:
-- -- tmp1: (Merchant_id,Location_id,User_Location_count)表示商家在某位置的总购买次数
-- -- train_feature_merchant_location_buy_count: (User_id,Location_id,Merchant_id,Merchant_Location_count:默认为0)


-- create table tmp1 as(
-- select Merchant_id, Location_id, count(*) as count
-- from train_before_10
-- group by Merchant_id, Location_id
-- );
-- create index tmp1_Merchant_Location on tmp1(Merchant_id,Location_id);

-- create table train_feature_merchant_location_buy_count(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Merchant_Location_count
-- from tr_d_new as A left join tmp1 as B on 
-- A.Merchant_id=B.Merchant_id and A.Location_id=B.Location_id
-- );
-- create index idx_Merchant_Location_buy on train_feature_merchant_location_buy_count(User_id,Merchant_id,Location_id);
-- drop table tmp1;

-- ------------------------------valid-----------------------------
-- create table tmp1 as(
-- select Merchant_id, Location_id, count(*) as count
-- from train_before_11
-- group by Merchant_id, Location_id
-- );
-- create index tmp1_Merchant_Location on tmp1(Merchant_id,Location_id);
-- 
-- create table valid_feature_merchant_location_buy_count(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Merchant_Location_count
-- from va_d_new as A left join tmp1 as B on 
-- A.Merchant_id=B.Merchant_id and A.Location_id=B.Location_id
-- );
-- create index idx_valid_Merchant_Location_buy on valid_feature_merchant_location_buy_count(User_id,Merchant_id,Location_id);
-- 
-- select * from tmp1 order by count desc limit 5;
-- select * from valid_feature_merchant_location_buy_count order by Merchant_Location_count desc limit 5;
-- 
-- drop table tmp1;



-- -----------------------------test----------------------------
create table tmp1 as(
select Merchant_id, Location_id, count(*) as count
from ijcai2016_koubei_train
group by Merchant_id, Location_id
);
create index tmp1_Merchant_Location on tmp1(Merchant_id,Location_id);

create table test_feature_merchant_location_buy_count(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Merchant_Location_count
from te_d_new as A left join tmp1 as B on 
A.Merchant_id=B.Merchant_id and A.Location_id=B.Location_id
);
create index idx_test_Merchant_Location_buy on test_feature_merchant_location_buy_count(User_id,Merchant_id,Location_id);

select * from tmp1 order by count desc limit 5;
select * from test_feature_merchant_location_buy_count order by Merchant_Location_count desc limit 5;

drop table tmp1;