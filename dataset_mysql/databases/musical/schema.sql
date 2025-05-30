-- Dialect: mysql | Database: musical | Table Count: 2

CREATE TABLE `musical`.`musical` (
    `Musical_ID` INT,
    `Name` TEXT,
    `Year` INT,
    `Award` TEXT,
    `Category` TEXT,
    `Nominee` TEXT,
    `Result` TEXT,
    PRIMARY KEY (`Musical_ID`)
);

CREATE TABLE `musical`.`actor` (
    `Actor_ID` INT,
    `Name` TEXT,
    `Musical_ID` INT,
    `Character` TEXT,
    `Duration` TEXT,
    `age` INT,
    PRIMARY KEY (`Actor_ID`),
    FOREIGN KEY (`Musical_ID`) REFERENCES `musical`.`actor` (`Actor_ID`)
);
