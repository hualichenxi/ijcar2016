use ijcai;

-- -----------------------------train----------------------------------------

create table tmp_x as (
select * from train_before_10
where  datediff("2015-10-01 00:00:00",Time_Stamp)>=1 and  datediff("2015-10-01 00:00:00",Time_Stamp)<=7
);

create table tmp1 as(
select User_id, Merchant_id, Location_id, count(*) as count
from tmp_x
group by User_id, Merchant_id, Location_id
);
create index idx_tmp1 on tmp1(User_id,Merchant_id,Location_id);

create table train_feature_buy_merchant_location_7days(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as User_Merchant_Location_count
from tr_d_new as A left join tmp1 as B on 
A.User_id=B.User_id and A.Merchant_id=B.Merchant_id and A.Location_id=B.Location_id
);
create index idx_train_feature_buy_merchant_location_7days on train_feature_buy_merchant_location_7days(User_id,Location_id,Merchant_id);


drop table tmp_x;
drop table tmp1;

-- -----------------------------test----------------------------------------

create table tmp_x as (
select * from ijcai2016_koubei_train
where  datediff("2015-12-01 00:00:00",Time_Stamp)>=1 and  datediff("2015-12-01 00:00:00",Time_Stamp)<=7
);

create table tmp1 as(
select User_id, Merchant_id, Location_id, count(*) as count
from tmp_x
group by User_id, Merchant_id, Location_id
);
create index idx_tmp1 on tmp1(User_id,Merchant_id,Location_id);

create table test_feature_buy_merchant_location_7days(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) as User_Merchant_Location_count
from te_d_new as A left join tmp1 as B on 
A.User_id=B.User_id and A.Merchant_id=B.Merchant_id and A.Location_id=B.Location_id
);
create index idx_test_feature_buy_merchant_location_7days on test_feature_buy_merchant_location_7days(User_id,Location_id,Merchant_id);


drop table tmp_x;
drop table tmp1;
