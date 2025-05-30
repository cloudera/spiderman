-- Dialect: mysql | Database: candidate_poll | Table Count: 2

CREATE TABLE `candidate_poll`.`people` (
    `People_ID` INT,
    `Sex` TEXT,
    `Name` TEXT,
    `Date_of_Birth` TEXT,
    `Height` REAL,
    `Weight` REAL,
    PRIMARY KEY (`People_ID`)
);

CREATE TABLE `candidate_poll`.`candidate` (
    `Candidate_ID` INT,
    `People_ID` INT,
    `Poll_Source` TEXT,
    `Date` TEXT,
    `Support_rate` REAL,
    `Consider_rate` REAL,
    `Oppose_rate` REAL,
    `Unsure_rate` REAL,
    PRIMARY KEY (`Candidate_ID`),
    FOREIGN KEY (`People_ID`) REFERENCES `candidate_poll`.`people` (`People_ID`)
);
