use ijcai;
create table train_before_11 as(
select * from ijcai2016_koubei_train  t
where t.Time_Stamp < '2015-11-01 00:00:00'
 );