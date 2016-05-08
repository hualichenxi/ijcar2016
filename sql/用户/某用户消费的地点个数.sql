-- generate features:
-- -- tmp1: (User_id,count)表示某用户消费消费地点个数
-- -- train_feature_user_location_count: (User_id,Location_id,Merchant_id,user_location_count:默认为0)


create table tmp1 as(
select User_id, count(distinct Location_id) as count
from train_before_10
group by User_id
);
create index tmp1_User on tmp1(User_id);

create table train_feature_user_location_count(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as User_Location_count
from tr_d_new as A left join tmp1 as B on 
A.User_id=B.User_id
);

select * from tmp1 order by count desc limit 5;
select * from train_feature_user_location_count order by User_Location_count desc limit 5;

drop table tmp1;