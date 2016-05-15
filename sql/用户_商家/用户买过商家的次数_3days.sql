-- -----------------------------train----------------------------------------
-- generate features:

create table if not exists tmp_xx as(
select User_id, Merchant_id,count(*) as count from train_before_10 
group by User_id,Merchant_id
where datediff("2015-10-01 00:00:00",Time_Stamp)>=1 and  datediff("2015-10-01 00:00:00",Time_Stamp)<=3
);

create table train_feature_buy_merchant_3days(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) 
as User_Merchant_count from tr_d_new as A left join tmp_xx as B on 
A.User_id=B.User_id and A.Merchant_id=B.Merchant_id
);

drop tmp_xx;

create index idx_feature_train_buy_merchant_3days on train_feature_buy_merchant_3days(User_id,Location_id,Merchant_id);



-- -----------------------------test----------------------------------------

create table if not exists tmp_xx as(
select User_id, Merchant_id,count(*) as count from ijcai2016_koubei_train 
group by User_id,Merchant_id
where datediff("2015-12-01 00:00:00",Time_Stamp)>=1 and  datediff("2015-12-01 00:00:00",Time_Stamp)<=3
);

create table train_feature_buy_merchant_3days(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.count,0) 
as User_Merchant_count from te_d_new as A left join tmp_xx as B on 
A.User_id=B.User_id and A.Merchant_id=B.Merchant_id
);

drop tmp_xx;

create index idx_feature_test_buy_merchant_3days on test_feature_buy_merchant_3days(User_id,Location_id,Merchant_id);

