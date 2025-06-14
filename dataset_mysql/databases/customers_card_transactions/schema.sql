-- Dialect: mysql | Database: customers_card_transactions | Table Count: 4

CREATE TABLE `customers_card_transactions`.`Accounts` (
    `account_id` INTEGER,
    `customer_id` INTEGER NOT NULL,
    `account_name` VARCHAR(50),
    `other_account_details` VARCHAR(255),
    PRIMARY KEY (`account_id`)
);

CREATE TABLE `customers_card_transactions`.`Customers` (
    `customer_id` INTEGER,
    `customer_first_name` VARCHAR(20),
    `customer_last_name` VARCHAR(20),
    `customer_address` VARCHAR(255),
    `customer_phone` VARCHAR(255),
    `customer_email` VARCHAR(255),
    `other_customer_details` VARCHAR(255),
    PRIMARY KEY (`customer_id`)
);

CREATE TABLE `customers_card_transactions`.`Customers_Cards` (
    `card_id` INTEGER,
    `customer_id` INTEGER NOT NULL,
    `card_type_code` VARCHAR(15) NOT NULL,
    `card_number` VARCHAR(80),
    `date_valid_from` DATETIME,
    `date_valid_to` DATETIME,
    `other_card_details` VARCHAR(255),
    PRIMARY KEY (`card_id`)
);

CREATE TABLE `customers_card_transactions`.`Financial_Transactions` (
    `transaction_id` INTEGER NOT NULL,
    `previous_transaction_id` INTEGER,
    `account_id` INTEGER NOT NULL,
    `card_id` INTEGER NOT NULL,
    `transaction_type` VARCHAR(15) NOT NULL,
    `transaction_date` DATETIME,
    `transaction_amount` DOUBLE,
    `transaction_comment` VARCHAR(255),
    `other_transaction_details` VARCHAR(255),
    FOREIGN KEY (`account_id`) REFERENCES `customers_card_transactions`.`Accounts` (`account_id`),
    FOREIGN KEY (`card_id`) REFERENCES `customers_card_transactions`.`Customers_Cards` (`card_id`)
);
