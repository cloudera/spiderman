CREATE DATABASE IF NOT EXISTS `city_record`;

drop table if exists `city_record`.`city`;
CREATE TABLE IF NOT EXISTS `city_record`.`city` (
    `City_ID` INT,
    `City` STRING,
    `Hanzi` STRING,
    `Hanyu_Pinyin` STRING,
    `Regional_Population` INT,
    `GDP` DOUBLE,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE
);

drop table if exists `city_record`.`match`;
CREATE TABLE IF NOT EXISTS `city_record`.`match` (
    `Match_ID` INT,
    `Date` STRING,
    `Venue` STRING,
    `Score` STRING,
    `Result` STRING,
    `Competition` STRING,
    PRIMARY KEY (`Match_ID`) DISABLE NOVALIDATE
);

drop table if exists `city_record`.`temperature`;
CREATE TABLE IF NOT EXISTS `city_record`.`temperature` (
    `City_ID` INT,
    `Jan` DOUBLE,
    `Feb` DOUBLE,
    `Mar` DOUBLE,
    `Apr` DOUBLE,
    `Jun` DOUBLE,
    `Jul` DOUBLE,
    `Aug` DOUBLE,
    `Sep` DOUBLE,
    `Oct` DOUBLE,
    `Nov` DOUBLE,
    `Dec` DOUBLE,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`City_ID`) REFERENCES `city_record`.`city` (`City_ID`) DISABLE NOVALIDATE
);

drop table if exists `city_record`.`hosting_city`;
CREATE TABLE IF NOT EXISTS `city_record`.`hosting_city` (
    `Year` INT,
    `Match_ID` INT,
    `Host_City` INT,
    PRIMARY KEY (`Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Match_ID`) REFERENCES `city_record`.`match` (`Match_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Host_City`) REFERENCES `city_record`.`city` (`City_ID`) DISABLE NOVALIDATE
);
