-- Dialect: mysql | Database: department_management | Table Count: 3

CREATE TABLE `department_management`.`department` (
    `Department_ID` INT,
    `Name` TEXT,
    `Creation` TEXT,
    `Ranking` INT,
    `Budget_in_Billions` REAL,
    `Num_Employees` REAL,
    PRIMARY KEY (`Department_ID`)
);

CREATE TABLE `department_management`.`head` (
    `head_ID` INT,
    `name` TEXT,
    `born_state` TEXT,
    `age` REAL,
    PRIMARY KEY (`head_ID`)
);

CREATE TABLE `department_management`.`management` (
    `department_ID` INT,
    `head_ID` INT,
    `temporary_acting` TEXT,
    PRIMARY KEY (`department_ID`, `head_ID`),
    FOREIGN KEY (`head_ID`) REFERENCES `department_management`.`head` (`head_ID`),
    FOREIGN KEY (`department_ID`) REFERENCES `department_management`.`department` (`Department_ID`)
);
