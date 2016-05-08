-- generate testing samples:



create table te_d as(
select A.User_id,A.Location_id,B.Merchant_id from (
select User_id,Location_id from ijcai2016_koubei_test 
) as A left join ijcai2016_merchant_info as B
on A.Location_id = B.Location_id
);
select count(*) from te_d;
select count(distinct User_id,Location_id,Merchant_id) from te_d;

create index idx_test_User_Location_Merchant on te_d(User_id,Location_id,Merchant_id);

