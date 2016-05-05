use ijcar;
select Merchant_id, count(*) as num from ijcai2016_merchant_info 
group by Merchant_id order by num desc; 