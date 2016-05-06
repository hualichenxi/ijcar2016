-- generate training samples:
-- -- X: (User_id,Merchant_id) in koubei_train from July 1st to Oct 31th
-- -- Y: buy  koubei_train from Nov 1st to Nov 30th
-- -- -- it is used for validation, we do not need to find negative samples.


use ijcai;
create table valid_X_Positive as(
select User_id,Location_id,Merchant_id
from ijcai2016_koubei_train where Time_Stamp<="2015-11-30 00:00:00" and Time_Stamp>="2015-11-01 00:00:00" 
order by Time_Stamp desc
);
