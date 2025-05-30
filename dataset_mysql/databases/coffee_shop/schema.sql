-- Dialect: mysql | Database: coffee_shop | Table Count: 4

CREATE TABLE `coffee_shop`.`shop` (
    `Shop_ID` INT,
    `Address` TEXT,
    `Num_of_staff` TEXT,
    `Score` REAL,
    `Open_Year` TEXT,
    PRIMARY KEY (`Shop_ID`)
);

CREATE TABLE `coffee_shop`.`member` (
    `Member_ID` INT,
    `Name` TEXT,
    `Membership_card` TEXT,
    `Age` INT,
    `Time_of_purchase` INT,
    `Level_of_membership` INT,
    `Address` TEXT,
    PRIMARY KEY (`Member_ID`)
);

CREATE TABLE `coffee_shop`.`happy_hour` (
    `HH_ID` INT,
    `Shop_ID` INT,
    `Month` VARCHAR(50),
    `Num_of_shaff_in_charge` INT,
    PRIMARY KEY (`HH_ID`, `Shop_ID`, `Month`),
    FOREIGN KEY (`Shop_ID`) REFERENCES `coffee_shop`.`shop` (`Shop_ID`)
);

CREATE TABLE `coffee_shop`.`happy_hour_member` (
    `HH_ID` INT,
    `Member_ID` INT,
    `Total_amount` REAL,
    PRIMARY KEY (`HH_ID`, `Member_ID`),
    FOREIGN KEY (`Member_ID`) REFERENCES `coffee_shop`.`member` (`Member_ID`)
);
