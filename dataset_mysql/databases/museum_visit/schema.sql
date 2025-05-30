-- Dialect: mysql | Database: museum_visit | Table Count: 3

CREATE TABLE `museum_visit`.`museum` (
    `Museum_ID` INT,
    `Name` TEXT,
    `Num_of_Staff` INT,
    `Open_Year` TEXT,
    PRIMARY KEY (`Museum_ID`)
);

CREATE TABLE `museum_visit`.`visitor` (
    `ID` INT,
    `Name` TEXT,
    `Level_of_membership` INT,
    `Age` INT,
    PRIMARY KEY (`ID`)
);

CREATE TABLE `museum_visit`.`visit` (
    `Museum_ID` INT,
    `visitor_ID` INT,
    `Num_of_Ticket` INT,
    `Total_spent` REAL,
    PRIMARY KEY (`Museum_ID`, `visitor_ID`),
    FOREIGN KEY (`visitor_ID`) REFERENCES `museum_visit`.`visitor` (`ID`),
    FOREIGN KEY (`Museum_ID`) REFERENCES `museum_visit`.`museum` (`Museum_ID`)
);
