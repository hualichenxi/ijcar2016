-- generate features:
-- -- tmp1: (Merchant_id,count)表示某商家分店数
-- -- train_feature_merchant_location_count: (User_id,Location_id,Merchant_id,Merchant_Location_count:默认为0)


-- create table tmp1 as(
-- select Merchant_id, count(Location_id) as count
-- from ijcai2016_merchant_info
-- group by Merchant_id
-- );
-- create index tmp1_Merchant on tmp1(Merchant_id);

-- create table train_feature_merchant_location_count(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Merchant_Location_count
-- from tr_d_new as A left join tmp1 as B on 
-- A.Merchant_id=B.Merchant_id
-- );

-- select * from tmp1 order by count desc limit 5;
-- select * from train_feature_merchant_location_count order by Merchant_Location_count desc limit 5;

-- drop table tmp1;


-- --------------------------------valid--------------------
-- create table tmp1 as(
-- select Merchant_id, count(Location_id) as count
-- from ijcai2016_merchant_info
-- group by Merchant_id
-- );
-- create index tmp1_Merchant on tmp1(Merchant_id);
-- 
-- create table valid_feature_merchant_location_count(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Merchant_Location_count
-- from va_d_new as A left join tmp1 as B on 
-- A.Merchant_id=B.Merchant_id
-- );
-- 
-- select * from tmp1 order by count desc limit 5;
-- select * from valid_feature_merchant_location_count order by Merchant_Location_count desc limit 5;
-- 
-- drop table tmp1;


-- --------------------------------test----------------------
create table tmp1 as(
select Merchant_id, count(Location_id) as count
from ijcai2016_merchant_info
group by Merchant_id
);
create index tmp1_Merchant on tmp1(Merchant_id);

create table test_feature_merchant_location_count(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Merchant_Location_count
from te_d_new as A left join tmp1 as B on 
A.Merchant_id=B.Merchant_id
);

select * from tmp1 order by count desc limit 5;
select * from test_feature_merchant_location_count order by Merchant_Location_count desc limit 5;

drop table tmp1;