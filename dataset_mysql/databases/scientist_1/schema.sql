-- Dialect: mysql | Database: scientist_1 | Table Count: 3

CREATE TABLE `scientist_1`.`Scientists` (
    `SSN` INT,
    `Name` CHAR(30) NOT NULL,
    PRIMARY KEY (`SSN`)
);

CREATE TABLE `scientist_1`.`Projects` (
    `Code` CHAR(4),
    `Name` CHAR(50) NOT NULL,
    `Hours` INT,
    PRIMARY KEY (`Code`)
);

CREATE TABLE `scientist_1`.`AssignedTo` (
    `Scientist` INT NOT NULL,
    `Project` CHAR(4) NOT NULL,
    PRIMARY KEY (`Scientist`, `Project`),
    FOREIGN KEY (`Project`) REFERENCES `scientist_1`.`Projects` (`Code`),
    FOREIGN KEY (`Scientist`) REFERENCES `scientist_1`.`Scientists` (`SSN`)
);
