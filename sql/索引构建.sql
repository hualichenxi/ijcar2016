create index tr_d_idx_User_id_Location_id_Merchant_id on tr_d(User_id,Location_id,Merchant_id);
create index tr_d_idx_User_id_Merchant_id on tr_d(User_id,Merchant_id);
create index tr_d_idx_User_id_Location_id on tr_d(User_id,Location_id);	

create index tr_d_idx_User_id on tr_d(User_id);	
create index tr_d_idx_Location_id on tr_d(Location_id);
create index tr_d_idx_Merchant_id on tr_d(Merchant_id);	