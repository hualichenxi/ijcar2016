use ijcai;
create table taobao_before_11 as(
select * from ijcai2016_taobao  t
where t.Time_Stamp < '2015-11-01 00:00:00'
 );
 
 create table taobao_before_10 as(
select * from ijcai2016_taobao  t
where t.Time_Stamp < '2015-10-01 00:00:00'
 );