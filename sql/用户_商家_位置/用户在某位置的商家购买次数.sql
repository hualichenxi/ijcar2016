-- generate features:
-- -- tmp1: (User_id,Merchant_id,Location_id,User_Merchant_Location_count)表示用户买过merchant的次数
-- -- train_feature_buy_merchant_location: (User_id,Location_id,Merchant_id,User_Merchant_count:默认为0)


-- create table if not exists tmp1 as(
-- select User_id, Merchant_id, Location_id, count(*) as count
-- from train_before_10
-- group by User_id, Merchant_id, Location_id
-- );
-- create index idx_tmp1 on tmp1(User_id,Merchant_id,Location_id);
-- 
-- create table if not exists train_feature_buy_merchant_location(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as User_Merchant_Location_count
-- from tr_d_new as A left join tmp1 as B on 
-- A.User_id=B.User_id and A.Merchant_id=B.Merchant_id and A.Location_id=B.Location_id
-- );
-- 
-- drop table tmp1;
-- 
-- create index idx_feature_buy_merchant_location on train_feature_buy_merchant_location(User_id,Location_id,Merchant_id);



-- create table if not exists tmp1 as(
-- select User_id, Merchant_id, Location_id, count(*) as count
-- from train_before_11
-- group by User_id, Merchant_id, Location_id
-- );
-- create index idx_tmp1 on tmp1(User_id,Merchant_id,Location_id);

-- create table if not exists valid_feature_buy_merchant_location(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as User_Merchant_Location_count
-- from tr_d_new as A left join tmp1 as B on 
-- A.User_id=B.User_id and A.Merchant_id=B.Merchant_id and A.Location_id=B.Location_id
-- );


-- select * from tmp1 order by count desc limit 5;
-- select * from valid_feature_buy_merchant_location order by User_Merchant_Location_count desc limit 5;
-- drop table tmp1;

-- create index idx_feature_buy_merchant_location on valid_feature_buy_merchant_location(User_id,Location_id,Merchant_id);





create table if not exists tmp1 as(
select User_id, Merchant_id, Location_id, count(*) as count
from ijcai2016_koubei_train
group by User_id, Merchant_id, Location_id
);
create index idx_tmp1 on tmp1(User_id,Merchant_id,Location_id);

create table if not exists test_feature_buy_merchant_location(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as User_Merchant_Location_count
from te_d_new as A left join tmp1 as B on 
A.User_id=B.User_id and A.Merchant_id=B.Merchant_id and A.Location_id=B.Location_id
);
create index idx_test_feature_buy_merchant_location on test_feature_buy_merchant_location(User_id,Location_id,Merchant_id);


select * from tmp1 order by count desc limit 5;
select * from test_feature_buy_merchant_location order by User_Merchant_Location_count desc limit 5;
drop table tmp1;






