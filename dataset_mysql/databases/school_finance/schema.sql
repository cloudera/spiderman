-- Dialect: mysql | Database: school_finance | Table Count: 3

CREATE TABLE `school_finance`.`School` (
    `School_id` INT,
    `School_name` TEXT,
    `Location` TEXT,
    `Mascot` TEXT,
    `Enrollment` INT,
    `IHSAA_Class` TEXT,
    `IHSAA_Football_Class` TEXT,
    `County` TEXT,
    PRIMARY KEY (`School_id`)
);

CREATE TABLE `school_finance`.`budget` (
    `School_id` INT,
    `Year` INT,
    `Budgeted` INT,
    `total_budget_percent_budgeted` REAL,
    `Invested` INT,
    `total_budget_percent_invested` REAL,
    `Budget_invested_percent` TEXT,
    PRIMARY KEY (`School_id`, `Year`),
    FOREIGN KEY (`School_id`) REFERENCES `school_finance`.`School` (`School_id`)
);

CREATE TABLE `school_finance`.`endowment` (
    `endowment_id` INT,
    `School_id` INT,
    `donator_name` TEXT,
    `amount` REAL,
    PRIMARY KEY (`endowment_id`),
    FOREIGN KEY (`School_id`) REFERENCES `school_finance`.`School` (`School_id`)
);
