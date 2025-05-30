-- Dialect: mysql | Database: city_record | Table Count: 4

CREATE TABLE `city_record`.`city` (
    `City_ID` INT,
    `City` TEXT,
    `Hanzi` TEXT,
    `Hanyu_Pinyin` TEXT,
    `Regional_Population` INT,
    `GDP` REAL,
    PRIMARY KEY (`City_ID`)
);

CREATE TABLE `city_record`.`match` (
    `Match_ID` INT,
    `Date` TEXT,
    `Venue` TEXT,
    `Score` TEXT,
    `Result` TEXT,
    `Competition` TEXT,
    PRIMARY KEY (`Match_ID`)
);

CREATE TABLE `city_record`.`temperature` (
    `City_ID` INT,
    `Jan` REAL,
    `Feb` REAL,
    `Mar` REAL,
    `Apr` REAL,
    `Jun` REAL,
    `Jul` REAL,
    `Aug` REAL,
    `Sep` REAL,
    `Oct` REAL,
    `Nov` REAL,
    `Dec` REAL,
    PRIMARY KEY (`City_ID`),
    FOREIGN KEY (`City_ID`) REFERENCES `city_record`.`city` (`City_ID`)
);

CREATE TABLE `city_record`.`hosting_city` (
    `Year` INT,
    `Match_ID` INT,
    `Host_City` INT,
    PRIMARY KEY (`Year`),
    FOREIGN KEY (`Match_ID`) REFERENCES `city_record`.`match` (`Match_ID`),
    FOREIGN KEY (`Host_City`) REFERENCES `city_record`.`city` (`City_ID`)
);
