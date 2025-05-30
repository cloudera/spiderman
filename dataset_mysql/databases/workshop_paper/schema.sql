-- Dialect: mysql | Database: workshop_paper | Table Count: 3

CREATE TABLE `workshop_paper`.`workshop` (
    `Workshop_ID` INT,
    `Date` TEXT,
    `Venue` TEXT,
    `Name` TEXT,
    PRIMARY KEY (`Workshop_ID`)
);

CREATE TABLE `workshop_paper`.`submission` (
    `Submission_ID` INT,
    `Scores` REAL,
    `Author` TEXT,
    `College` TEXT,
    PRIMARY KEY (`Submission_ID`)
);

CREATE TABLE `workshop_paper`.`Acceptance` (
    `Submission_ID` INT,
    `Workshop_ID` INT,
    `Result` TEXT,
    PRIMARY KEY (`Submission_ID`, `Workshop_ID`),
    FOREIGN KEY (`Workshop_ID`) REFERENCES `workshop_paper`.`workshop` (`Workshop_ID`),
    FOREIGN KEY (`Submission_ID`) REFERENCES `workshop_paper`.`submission` (`Submission_ID`)
);
