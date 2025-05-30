-- Dialect: mysql | Database: allergy_1 | Table Count: 3

CREATE TABLE `allergy_1`.`Allergy_Type` (
    `Allergy` VARCHAR(20),
    `AllergyType` VARCHAR(20),
    PRIMARY KEY (`Allergy`)
);

CREATE TABLE `allergy_1`.`Student` (
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

CREATE TABLE `allergy_1`.`Has_Allergy` (
    `StuID` INTEGER,
    `Allergy` VARCHAR(20),
    FOREIGN KEY (`Allergy`) REFERENCES `allergy_1`.`Allergy_Type` (`Allergy`),
    FOREIGN KEY (`StuID`) REFERENCES `allergy_1`.`Student` (`StuID`)
);
