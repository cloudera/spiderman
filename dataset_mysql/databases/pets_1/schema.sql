-- Dialect: mysql | Database: pets_1 | Table Count: 3

CREATE TABLE `pets_1`.`Student` (
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

CREATE TABLE `pets_1`.`Pets` (
    `PetID` INTEGER,
    `PetType` VARCHAR(20),
    `pet_age` INTEGER,
    `weight` REAL,
    PRIMARY KEY (`PetID`)
);

CREATE TABLE `pets_1`.`Has_Pet` (
    `StuID` INTEGER,
    `PetID` INTEGER,
    FOREIGN KEY (`StuID`) REFERENCES `pets_1`.`Student` (`StuID`),
    FOREIGN KEY (`PetID`) REFERENCES `pets_1`.`Pets` (`PetID`)
);
