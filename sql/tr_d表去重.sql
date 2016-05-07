-- create table if not exists tr_d_new as (select distinct 
-- User_id,Location_id,Merchant_id,Label from tr_d);

create table if not exists va_d_new as (select distinct 
User_id,Location_id,Merchant_id,Label from va_d);
