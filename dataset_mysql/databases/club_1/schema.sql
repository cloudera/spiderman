-- Dialect: mysql | Database: club_1 | Table Count: 3

CREATE TABLE `club_1`.`Student` (
    `StuID` INTEGER,
    `LName` VARCHAR(12),
    `Fname` VARCHAR(12),
    `Age` INTEGER,
    `Sex` VARCHAR(1),
    `Major` INTEGER,
    `Advisor` INTEGER,
    `city_code` VARCHAR(3),
    PRIMARY KEY (`StuID`)
);

CREATE TABLE `club_1`.`Club` (
    `ClubID` INTEGER,
    `ClubName` VARCHAR(40),
    `ClubDesc` VARCHAR(1024),
    `ClubLocation` VARCHAR(40),
    PRIMARY KEY (`ClubID`)
);

CREATE TABLE `club_1`.`Member_of_club` (
    `StuID` INTEGER,
    `ClubID` INTEGER,
    `Position` VARCHAR(40),
    FOREIGN KEY (`ClubID`) REFERENCES `club_1`.`Club` (`ClubID`),
    FOREIGN KEY (`StuID`) REFERENCES `club_1`.`Student` (`StuID`)
);
