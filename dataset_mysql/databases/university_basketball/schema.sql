-- Dialect: mysql | Database: university_basketball | Table Count: 2

CREATE TABLE `university_basketball`.`university` (
    `School_ID` INT,
    `School` TEXT,
    `Location` TEXT,
    `Founded` REAL,
    `Affiliation` TEXT,
    `Enrollment` REAL,
    `Nickname` TEXT,
    `Primary_conference` TEXT,
    PRIMARY KEY (`School_ID`)
);

CREATE TABLE `university_basketball`.`basketball_match` (
    `Team_ID` INT,
    `School_ID` INT,
    `Team_Name` TEXT,
    `ACC_Regular_Season` TEXT,
    `ACC_Percent` TEXT,
    `ACC_Home` TEXT,
    `ACC_Road` TEXT,
    `All_Games` TEXT,
    `All_Games_Percent` INT,
    `All_Home` TEXT,
    `All_Road` TEXT,
    `All_Neutral` TEXT,
    PRIMARY KEY (`Team_ID`),
    FOREIGN KEY (`School_ID`) REFERENCES `university_basketball`.`university` (`School_ID`)
);
