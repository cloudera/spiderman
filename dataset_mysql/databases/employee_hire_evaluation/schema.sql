-- Dialect: mysql | Database: employee_hire_evaluation | Table Count: 4

CREATE TABLE `employee_hire_evaluation`.`employee` (
    `Employee_ID` INT,
    `Name` TEXT,
    `Age` INT,
    `City` TEXT,
    PRIMARY KEY (`Employee_ID`)
);

CREATE TABLE `employee_hire_evaluation`.`shop` (
    `Shop_ID` INT,
    `Name` TEXT,
    `Location` TEXT,
    `District` TEXT,
    `Number_products` INT,
    `Manager_name` TEXT,
    PRIMARY KEY (`Shop_ID`)
);

CREATE TABLE `employee_hire_evaluation`.`hiring` (
    `Shop_ID` INT,
    `Employee_ID` INT,
    `Start_from` TEXT,
    `Is_full_time` CHAR(1),
    PRIMARY KEY (`Employee_ID`),
    FOREIGN KEY (`Employee_ID`) REFERENCES `employee_hire_evaluation`.`employee` (`Employee_ID`),
    FOREIGN KEY (`Shop_ID`) REFERENCES `employee_hire_evaluation`.`shop` (`Shop_ID`)
);

CREATE TABLE `employee_hire_evaluation`.`evaluation` (
    `Employee_ID` INT,
    `Year_awarded` VARCHAR(50),
    `Bonus` REAL,
    PRIMARY KEY (`Employee_ID`, `Year_awarded`),
    FOREIGN KEY (`Employee_ID`) REFERENCES `employee_hire_evaluation`.`employee` (`Employee_ID`)
);
