-- generate features:
-- -- tmp1: (User_id,count)表示某用户总的购买次数
-- -- train_feature_user—_buy_count: (User_id,Location_id,Merchant_id,user_buy_count:默认为0)


create table tmp1 as(
select User_id, count(*) as count
from train_before_10
group by User_id
);
create index tmp1_User on tmp1(User_id);

create table train_feature_user_buy_count(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as User_buy_count
from tr_d_new as A left join tmp1 as B on 
A.User_id=B.User_id
);

select * from tmp1 order by count desc limit 5;
select * from train_feature_user_buy_count order by User_buy_count desc limit 5;

drop table tmp1;