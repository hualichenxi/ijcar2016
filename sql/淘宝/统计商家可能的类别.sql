
-- 创建表taobao_user_cate_count：淘宝用户访问类别的统计
create table taobao_user_cate_count as (select User_id,Category_id,Time_Stamp,count(*) as count from taobao_U_C group by User_id,Category_id,Time_Stamp);
create index t_user on taobao_user_cate_count(User_id);

-- 统计用户在线下一个merchant之前一天的网上购物类别统计，count表示对应用户前一天网上浏览该类别的总次数，
--  off_on_stat_tmp(merchant_id,category_id,count),

create table off_on_stat_tmp as (
select A.Merchant_id, B.Category_id, B.count from ijcai2016_koubei_train as A 
,taobao_user_cate_count as B where A.User_id=B.User_id
and datediff(A.Time_Stamp,B.Time_Stamp)=1
);



-- 聚合count
-- off_on_stat(merchant_id,category_id,total_count)

create table off_on_stat as (select Merchant_id,Category_id,sum(count)
 as total_count from off_on_stat_tmp group by Merchant_id,Category_id);