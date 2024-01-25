drop table if exists `customers_card_transactions`.`Accounts`;
CREATE TABLE IF NOT EXISTS `customers_card_transactions`.`Accounts` (
    `account_id` INT,
    `customer_id` INT NOT NULL,
    `account_name` STRING,
    `other_account_details` STRING,
    PRIMARY KEY (`account_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_card_transactions/data/Accounts.csv' INTO TABLE `customers_card_transactions`.`Accounts`;


drop table if exists `customers_card_transactions`.`Customers`;
CREATE TABLE IF NOT EXISTS `customers_card_transactions`.`Customers` (
    `customer_id` INT,
    `customer_first_name` STRING,
    `customer_last_name` STRING,
    `customer_address` STRING,
    `customer_phone` STRING,
    `customer_email` STRING,
    `other_customer_details` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_card_transactions/data/Customers.csv' INTO TABLE `customers_card_transactions`.`Customers`;


drop table if exists `customers_card_transactions`.`Customers_Cards`;
CREATE TABLE IF NOT EXISTS `customers_card_transactions`.`Customers_Cards` (
    `card_id` INT,
    `customer_id` INT NOT NULL,
    `card_type_code` STRING NOT NULL,
    `card_number` STRING,
    `date_valid_from` TIMESTAMP,
    `date_valid_to` TIMESTAMP,
    `other_card_details` STRING,
    PRIMARY KEY (`card_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_card_transactions/data/Customers_Cards.csv' INTO TABLE `customers_card_transactions`.`Customers_Cards`;


drop table if exists `customers_card_transactions`.`Financial_Transactions`;
CREATE TABLE IF NOT EXISTS `customers_card_transactions`.`Financial_Transactions` (
    `transaction_id` INT NOT NULL,
    `previous_transaction_id` INT,
    `account_id` INT NOT NULL,
    `card_id` INT NOT NULL,
    `transaction_type` STRING NOT NULL,
    `transaction_date` TIMESTAMP,
    `transaction_amount` REAL,
    `transaction_comment` STRING,
    `other_transaction_details` STRING,
    FOREIGN KEY (`account_id`) REFERENCES `customers_card_transactions`.`Accounts` (`account_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`card_id`) REFERENCES `customers_card_transactions`.`Customers_Cards` (`card_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_card_transactions/data/Financial_Transactions.csv' INTO TABLE `customers_card_transactions`.`Financial_Transactions`;

