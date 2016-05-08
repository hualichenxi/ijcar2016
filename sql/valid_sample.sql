-- generate validating samples:
-- -- X: (User_id,Merchant_id) in koubei_train from July 1st to Oct 31th
-- -- Y: buy  koubei_train from Nov 1st to Nov 30th
-- -- -- it is used for validation, we do not need to find negative samples.


use ijcai;
create table valid_X_Positive as(
select User_id,Location_id,Merchant_id,1 as Label
from ijcai2016_koubei_train where Time_Stamp<="2015-11-30 00:00:00" and Time_Stamp>="2015-11-01 00:00:00" 
order by Time_Stamp desc
);

create table tmp as(
select A.User_id,A.Location_id,B.Merchant_id from (
select User_id,Location_id from ijcai2016_koubei_train 
where Time_Stamp<="2015-11-30 00:00:00" and Time_Stamp>="2015-11-01 00:00:00" 
) as A left join ijcai2016_merchant_info as B
on A.Location_id = B.Location_id
);

create index idx_User_id_Location_id on tmp(User_id,Location_id);
create index idx_User_id_Merchant_id on valid_X_Positive(User_id,Merchant_id);

create table valid_X_Negative as(
select User_id,Location_id,Merchant_id,0 as Label from tmp
where (User_id,Merchant_id) not in (	
select User_id,Merchant_id from train_X_Positive
)
);

drop table tmp;

create table va_d as(
select * from valid_X_Positive);
insert into va_d select * from valid_X_Negative;