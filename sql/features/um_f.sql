use ijcai;

-- how many times the user bought the merchant
create table tmp as (
select tr_d.User_id,tr_d.Merchant_id,count(f.Um_buy) as buy_num from
tr_d left join (
select User_id,Merchant_id,1 as Um_buy from ijcai2016_koubei_train where Time_Stamp<="2015-09-30 00:00:00"
) as f
on tr_d.User_id=f.User_id and tr_d.Merchant_id = f.Merchant_id
group by tr_d.User_id,tr_d.Merchant_id
)
;
create table Um_buy as(
select tr_d.User_id,tr_d.Location_id,tr_d.Merchant_id,tmp.buy_num from
tr_d left join tmp
on tr_d.User_id = tmp.User_id and tr_d.Merchant_id = tmp.Merchant_id
);
drop table tmp;