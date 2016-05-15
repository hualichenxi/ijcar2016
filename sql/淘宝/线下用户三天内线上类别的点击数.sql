
-- 创建用户点击表
create table taobao_user_click_count as (
select User_id,Category_id,Time_Stamp from ijcai2016_taobao
where Online_Action_id=0
);


-- 创建表taobao_user_cate_click_count：淘宝用户每天点击某个类别的统计
create table taobao_user_cate_click_count as (select User_id,Category_id,Time_Stamp,count(*) 
	as click_count from taobao_user_click_count
	group by User_id,Category_id,Time_Stamp);

create index t_click_user on taobao_user_cate_click_count(User_id);



-- -----------------------------train----------------------------------------
-- 统计用户在线下一个merchant之前3天的网上购物类别统计，count表示对应用户前3天网上浏览该类别的总次数，
--  tmp_x(User_id,category_id,count),

create table tmp_x as (
select A.User_id, B.Category_id, B.click_count from train_before_10 as A 
,taobao_user_cate_click_count as B where A.User_id=B.User_id
and datediff(A.Time_Stamp,B.Time_Stamp)>=1 and datediff(A.Time_Stamp,B.Time_Stamp)<=3
);

-- 聚合3天的点击数量
-- user_cate_click_3days(merchant_id,category_id,total_count)

create table train_user_cate_click_3days as (select User_id,Category_id,sum(click_count)
 as total_count from tmp_x group by User_id,Category_id);




-- -----------------------------test----------------------------------------
-- 统计用户在线下一个merchant之前3天的网上购物类别统计，count表示对应用户前3天网上浏览该类别的总次数，
--  tmp_x(User_id,category_id,count),

create table tmp_x as (
select A.User_id, B.Category_id, B.click_count from ijcai2016_koubei_test as A 
,taobao_user_cate_click_count as B where A.User_id=B.User_id
and datediff("2015-12-01",B.Time_Stamp)>=1 and datediff("2015-12-01",B.Time_Stamp)<=3
);

-- 聚合3天的点击数量
-- user_cate_click_3days(merchant_id,category_id,total_count)

create table test_user_cate_click_3days as (select User_id,Category_id,sum(click_count)
 as total_count from tmp_x group by User_id,Category_id);



