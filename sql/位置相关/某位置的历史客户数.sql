-- generate features:
-- -- tmp1: (Location_id,count)表示某位置历史用户数量
-- -- train_feature_location_user_count: (User_id,Location_id,Merchant_id,Location_user_count:默认为0)


-- create table tmp1 as(
-- select Location_id, count(distinct user_id) as count
-- from train_before_10
-- group by Location_id
-- );
-- create index tmp1_Location on tmp1(Location_id);

-- create table train_feature_location_user_count(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Location_User_count
-- from tr_d_new as A left join tmp1 as B on 
-- A.Location_id=B.Location_id
-- );

-- create index idx_Location_User on train_feature_location_user_count(User_id,Merchant_id,Location_id);

-- select * from tmp1 order by count desc limit 5;
-- select * from train_feature_location_user_count order by Location_User_count desc limit 5;

-- drop table tmp1;
create table tmp1 as(
select Location_id, count(distinct user_id) as count
from train_before_11
group by Location_id
);
create index tmp1_Location on tmp1(Location_id);

create table valid_feature_location_user_count(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Location_User_count
from va_d_new as A left join tmp1 as B on 
A.Location_id=B.Location_id
);

create index idx_valid_Location_User on valid_feature_location_user_count(User_id,Merchant_id,Location_id);

select * from tmp1 order by count desc limit 5;
select * from valid_feature_location_user_count order by Location_User_count desc limit 5;

drop table tmp1;