-- generate features:
-- -- tmp1: (Merchant_id,count)表示某商家历史消费数量
-- -- train_feature_merchant_buy_count: (User_id,Location_id,Merchant_id,Merchant_buy_count:默认为0)


create table tmp1 as(
select Merchant_id, count(*) as count
from train_before_10
group by Merchant_id
);
create index tmp1_Merchant on tmp1(Merchant_id);

create table train_feature_merchant_buy_count(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as Merchant_buy_count
from tr_d_new as A left join tmp1 as B on 
A.Merchant_id=B.Merchant_id
);

select * from tmp1 order by count desc limit 5;
select * from train_feature_merchant_buy_count order by Merchant_buy_count desc limit 5;

drop table tmp1;