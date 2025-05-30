-- Dialect: mysql | Database: pilot_record | Table Count: 3

CREATE TABLE `pilot_record`.`aircraft` (
    `Aircraft_ID` INT,
    `Order_Year` INT,
    `Manufacturer` TEXT,
    `Model` TEXT,
    `Fleet_Series` TEXT,
    `Powertrain` TEXT,
    `Fuel_Propulsion` TEXT,
    PRIMARY KEY (`Aircraft_ID`)
);

CREATE TABLE `pilot_record`.`pilot` (
    `Pilot_ID` INT,
    `Pilot_name` TEXT,
    `Rank` INT,
    `Age` INT,
    `Nationality` TEXT,
    `Position` TEXT,
    `Join_Year` INT,
    `Team` TEXT,
    PRIMARY KEY (`Pilot_ID`)
);

CREATE TABLE `pilot_record`.`pilot_record` (
    `Record_ID` INT,
    `Pilot_ID` INT,
    `Aircraft_ID` INT,
    `Date` DATE,
    PRIMARY KEY (`Pilot_ID`, `Aircraft_ID`, `Date`),
    FOREIGN KEY (`Aircraft_ID`) REFERENCES `pilot_record`.`aircraft` (`Aircraft_ID`),
    FOREIGN KEY (`Pilot_ID`) REFERENCES `pilot_record`.`pilot` (`Pilot_ID`)
);
