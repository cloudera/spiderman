CREATE DATABASE IF NOT EXISTS `tracking_share_transactions`;

drop table if exists `tracking_share_transactions`.`Investors`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Investors` (
    `investor_id` INT,
    `Investor_details` STRING,
    PRIMARY KEY (`investor_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Investors.csv' INTO TABLE `tracking_share_transactions`.`Investors`;


drop table if exists `tracking_share_transactions`.`Lots`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Lots` (
    `lot_id` INT,
    `investor_id` INT NOT NULL,
    `lot_details` STRING,
    PRIMARY KEY (`lot_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`investor_id`) REFERENCES `tracking_share_transactions`.`Investors` (`investor_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Lots.csv' INTO TABLE `tracking_share_transactions`.`Lots`;


drop table if exists `tracking_share_transactions`.`Ref_Transaction_Types`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Ref_Transaction_Types` (
    `transaction_type_code` STRING,
    `transaction_type_description` STRING NOT NULL,
    PRIMARY KEY (`transaction_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Ref_Transaction_Types.csv' INTO TABLE `tracking_share_transactions`.`Ref_Transaction_Types`;


drop table if exists `tracking_share_transactions`.`Transactions`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Transactions` (
    `transaction_id` INT,
    `investor_id` INT NOT NULL,
    `transaction_type_code` STRING NOT NULL,
    `date_of_transaction` TIMESTAMP,
    `amount_of_transaction` DECIMAL(19,4),
    `share_count` STRING,
    `other_details` STRING,
    PRIMARY KEY (`transaction_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`transaction_type_code`) REFERENCES `tracking_share_transactions`.`Ref_Transaction_Types` (`transaction_type_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`investor_id`) REFERENCES `tracking_share_transactions`.`Investors` (`investor_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Transactions.csv' INTO TABLE `tracking_share_transactions`.`Transactions`;


drop table if exists `tracking_share_transactions`.`Sales`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Sales` (
    `sales_transaction_id` INT,
    `sales_details` STRING,
    PRIMARY KEY (`sales_transaction_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`sales_transaction_id`) REFERENCES `tracking_share_transactions`.`Transactions` (`transaction_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Sales.csv' INTO TABLE `tracking_share_transactions`.`Sales`;


drop table if exists `tracking_share_transactions`.`Purchases`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Purchases` (
    `purchase_transaction_id` INT NOT NULL,
    `purchase_details` STRING NOT NULL,
    FOREIGN KEY (`purchase_transaction_id`) REFERENCES `tracking_share_transactions`.`Transactions` (`transaction_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Purchases.csv' INTO TABLE `tracking_share_transactions`.`Purchases`;


drop table if exists `tracking_share_transactions`.`Transactions_Lots`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Transactions_Lots` (
    `transaction_id` INT NOT NULL,
    `lot_id` INT NOT NULL,
    FOREIGN KEY (`transaction_id`) REFERENCES `tracking_share_transactions`.`Transactions` (`transaction_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`lot_id`) REFERENCES `tracking_share_transactions`.`Lots` (`lot_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Transactions_Lots.csv' INTO TABLE `tracking_share_transactions`.`Transactions_Lots`;

