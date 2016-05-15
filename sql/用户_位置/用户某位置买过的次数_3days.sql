-- -----------------------------train----------------------------------------
-- generate features:

create table tmp_x as (
select * from train_before_10
where  datediff("2015-12-01 00:00:00",Time_Stamp)>=1 and  datediff("2015-12-01 00:00:00",Time_Stamp)<=3
);

create table if not exists tmp_xx as(
select User_id, Location_id,count(*) as count from tmp_x 
group by User_id,Location_id
);

create index idx_index on tmp_xx(User_id,Location_id);

create table train_feature_buy_location_3days(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) 
as User_Loaction_count from tr_d_new as A left join tmp_xx as B on 
A.User_id=B.User_id and A.Location_id=B.Location_id
);

drop table tmp_xx;
drop table tmp_x;
create index idx_feature_train_buy_location_3days on train_feature_buy_location_3days(User_id,Location_id,Merchant_id);



-- -----------------------------test----------------------------------------

create table tmp_x as (
select * from ijcai2016_koubei_train
where  datediff("2015-12-01 00:00:00",Time_Stamp)>=1 and  datediff("2015-12-01 00:00:00",Time_Stamp)<=3
);

create table if not exists tmp_xx as(
select User_id, Location_id,count(*) as count from tmp_x 
group by User_id,Location_id
);

create index idx_index on tmp_xx(User_id,Location_id);

create table test_feature_buy_location_3days(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) 
as User_Merchant_count from te_d_new as A left join tmp_xx as B on 
A.User_id=B.User_id and A.Location_id=B.Location_id
);

drop table tmp_xx;
drop table tmp_x;

create index idx_feature_test_buy_location_3days on test_feature_buy_location_3days(User_id,Location_id,Merchant_id);

