use ijcai;

CREATE TABLE `ijcai2016_merchant_info` (
  `Merchant_id` int(11) DEFAULT '0',
  `Budget` int(11) DEFAULT NULL,
  `Location_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `ijcai2016_taobao` (
  `User_id` int(11) DEFAULT NULL,
  `Seller_id` int(11) DEFAULT NULL,
  `Item_id` int(11) DEFAULT NULL,
  `Category_id` int(11) DEFAULT NULL,
  `Online_Action_id` int(11) DEFAULT NULL,
  `Time_Stamp` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ijcai2016_koubei_test` (
  `User_id` int(11) DEFAULT NULL,
  `Location_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ijcai2016_koubei_train` (
  `User_id` int(11) DEFAULT NULL,
  `Merchant_id` int(11) DEFAULT NULL,
  `Location_id` int(11) DEFAULT NULL,
  `Time_Stamp` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;