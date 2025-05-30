-- Dialect: mysql | Database: party_host | Table Count: 3

CREATE TABLE `party_host`.`party` (
    `Party_ID` INT,
    `Party_Theme` TEXT,
    `Location` TEXT,
    `First_year` TEXT,
    `Last_year` TEXT,
    `Number_of_hosts` INT,
    PRIMARY KEY (`Party_ID`)
);

CREATE TABLE `party_host`.`host` (
    `Host_ID` INT,
    `Name` TEXT,
    `Nationality` TEXT,
    `Age` TEXT,
    PRIMARY KEY (`Host_ID`)
);

CREATE TABLE `party_host`.`party_host` (
    `Party_ID` INT,
    `Host_ID` INT,
    `Is_Main_in_Charge` CHAR(1),
    PRIMARY KEY (`Party_ID`, `Host_ID`),
    FOREIGN KEY (`Party_ID`) REFERENCES `party_host`.`party` (`Party_ID`),
    FOREIGN KEY (`Host_ID`) REFERENCES `party_host`.`host` (`Host_ID`)
);
