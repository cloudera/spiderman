-- Dialect: mysql | Database: journal_committee | Table Count: 3

CREATE TABLE `journal_committee`.`journal` (
    `Journal_ID` INT,
    `Date` TEXT,
    `Theme` TEXT,
    `Sales` INT,
    PRIMARY KEY (`Journal_ID`)
);

CREATE TABLE `journal_committee`.`editor` (
    `Editor_ID` INT,
    `Name` TEXT,
    `Age` REAL,
    PRIMARY KEY (`Editor_ID`)
);

CREATE TABLE `journal_committee`.`journal_committee` (
    `Editor_ID` INT,
    `Journal_ID` INT,
    `Work_Type` TEXT,
    PRIMARY KEY (`Editor_ID`, `Journal_ID`),
    FOREIGN KEY (`Journal_ID`) REFERENCES `journal_committee`.`journal` (`Journal_ID`),
    FOREIGN KEY (`Editor_ID`) REFERENCES `journal_committee`.`editor` (`Editor_ID`)
);
