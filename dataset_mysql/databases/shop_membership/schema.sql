-- Dialect: mysql | Database: shop_membership | Table Count: 4

CREATE TABLE `shop_membership`.`member` (
    `Member_ID` INT,
    `Card_Number` TEXT,
    `Name` TEXT,
    `Hometown` TEXT,
    `Level` INT,
    PRIMARY KEY (`Member_ID`)
);

CREATE TABLE `shop_membership`.`branch` (
    `Branch_ID` INT,
    `Name` TEXT,
    `Open_year` TEXT,
    `Address_road` TEXT,
    `City` TEXT,
    `membership_amount` TEXT,
    PRIMARY KEY (`Branch_ID`)
);

CREATE TABLE `shop_membership`.`membership_register_branch` (
    `Member_ID` INT,
    `Branch_ID` INT,
    `Register_Year` TEXT,
    PRIMARY KEY (`Member_ID`),
    FOREIGN KEY (`Branch_ID`) REFERENCES `shop_membership`.`branch` (`Branch_ID`),
    FOREIGN KEY (`Member_ID`) REFERENCES `shop_membership`.`member` (`Member_ID`)
);

CREATE TABLE `shop_membership`.`purchase` (
    `Member_ID` INT,
    `Branch_ID` INT,
    `Year` VARCHAR(10),
    `Total_pounds` REAL,
    PRIMARY KEY (`Member_ID`, `Branch_ID`, `Year`),
    FOREIGN KEY (`Branch_ID`) REFERENCES `shop_membership`.`branch` (`Branch_ID`),
    FOREIGN KEY (`Member_ID`) REFERENCES `shop_membership`.`member` (`Member_ID`)
);
