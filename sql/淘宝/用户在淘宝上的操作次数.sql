use ijcai;

-- generate features: user's click and buy number on taobao

-- -----------------------------train----------------------------------------
-- create table tmp1 as(
-- select User_id,count(*) as click_count from taobao_before_10 where Online_Action_id=0 group by User_id
-- );
-- 
-- create index idx_tmp1 on tmp1(User_id);
-- 
-- create table tmp2 as(
-- select User_id,count(*) as buy_count from taobao_before_10 where Online_Action_id=1 group by User_id
-- );
-- 
-- create index idx_tmp2 on tmp2(User_id);
-- 
-- create table tmp3 as(
-- select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.click_count,0) as Taobao_User_Click_count
-- from tr_d_new as A left join tmp1 as B
-- on A.User_id = B.User_id
-- );
-- 
-- create table train_feature_taobao_user_click as(
-- select A.User_id,A.Location_id,A.Merchant_id,A.Taobao_User_Click_count,
-- IFNULL(B.buy_count,0) as Taobao_User_Buy_count
-- from tmp3 as A left join tmp2 as B
-- on A.User_id = B.User_id
-- );
-- 
-- 
-- drop table tmp1;
-- drop table tmp2;
-- drop table tmp3;
-- 
-- create index idx_feature_taobao_user_click on train_feature_taobao_user_click(User_id,Location_id,Merchant_id);

-- -----------------------------------------test--------------------------------------
create table tmp1 as(
select User_id,count(*) as click_count from ijcai2016_taobao where Online_Action_id=0 group by User_id
);

create index idx_tmp1 on tmp1(User_id);

create table tmp2 as(
select User_id,count(*) as buy_count from taobao_before_10 where Online_Action_id=1 group by User_id
);

create index idx_tmp2 on tmp2(User_id);

create table tmp3 as(
select A.User_id,A.Location_id,A.Merchant_id,IFNULL(B.click_count,0) as Taobao_User_Click_count
from te_d_new as A left join tmp1 as B
on A.User_id = B.User_id
);

create table test_feature_taobao_user_click as(
select A.User_id,A.Location_id,A.Merchant_id,A.Taobao_User_Click_count,
IFNULL(B.buy_count,0) as Taobao_User_Buy_count
from tmp3 as A left join tmp2 as B
on A.User_id = B.User_id
);


drop table tmp1;
drop table tmp2;
drop table tmp3;

create index idx_feature_taobao_user_click on test_feature_taobao_user_click(User_id,Location_id,Merchant_id);