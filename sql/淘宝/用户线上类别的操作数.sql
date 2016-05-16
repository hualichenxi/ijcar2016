use ijcai;
create table train_user_cate_click as (
	select User_id,Category_id,count(*) as total_count 
    from taobao_before_10 where Online_Action_id = 0 
    group by User_id,Category_id
    order by User_id,Category_id
);


create table test_user_cate_click as (
	select User_id,Category_id,count(*) as total_count 
    from ijcai2016_taobao where Online_Action_id = 0 
    group by User_id,Category_id
    order by User_id,Category_id
);

create table train_user_cate_buy as (
	select User_id,Category_id,count(*) as total_count 
    from taobao_before_10 where Online_Action_id = 1
    group by User_id,Category_id
    order by User_id,Category_id
);


create table test_user_cate_buy as (
	select User_id,Category_id,count(*) as total_count 
    from ijcai2016_taobao where Online_Action_id = 1
    group by User_id,Category_id
    order by User_id,Category_id
);